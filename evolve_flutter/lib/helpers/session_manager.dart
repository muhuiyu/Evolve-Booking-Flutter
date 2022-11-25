import 'dart:developer';

import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/models/date.dart';
import 'package:evolve_flutter/models/session.dart';

class SessionManager {
  static SessionManager shared = SessionManager();

  final Map<SessionId, Session> _cachedSessions = {};
  final Map<Date, Set<SessionId>> _sessionsGroupedByDate = {};
  final Set<SessionId> _bookedSessions = {};

  /// Returns sessions on a given date
  Future<List<Session>> getSessionsOnDate(
      Date date, ApiClient client, List<Membership> memberships) async {
    if (!_sessionsGroupedByDate.containsKey(date)) {
      await _fetchSessionsFromDate(date, client, memberships);
    }
    return _getSessionsForIds(_sessionsGroupedByDate[date]?.toList() ?? [],
        isSortedByDate: true);
  }

  /// Returns upcoming booked sessions
  Future<List<Session>> getUpcomingBookedSessions(
      ApiClient client, List<Membership> memberships) async {
    var today = Date.today;
    if (_sessionsGroupedByDate.containsKey(_getMaximumBookableDate())) {
      return _filterFutureBookedSessions();
    }
    await _fetchSessionsFromDate(today, client, memberships); // get latest data
    return _filterFutureBookedSessions();
  }

  /// Returns past sessions
  Future<List<Session>> getSessionsBookedInThePastWeek(
      ApiClient client, List<Membership> memberships) async {
    var dayOneWeekAgo = Date.today.add(const Duration(days: -7));
    var dayFourDaysAgo = Date.today.add(const Duration(days: -4));

    if (_sessionsGroupedByDate.containsKey(dayOneWeekAgo)) {
      return _filterPastBookedSessions();
    }
    await _fetchSessionsFromDate(dayOneWeekAgo, client, memberships);
    await _fetchSessionsFromDate(dayFourDaysAgo, client, memberships);
    return _filterFutureBookedSessions();
  }

  Future<void> cancelSession(
      ApiClient client, List<Membership> memberships, Session session) async {
    final responseBodies = await client.performRequest(Api.cancelEventBooking(
        memberId: memberships.first.memberId,
        eventDate: session.date.toYearMonthDay,
        eventId: session.rawId));
    _cachedSessions[session.id]?.isBookedByMe = false;
    _bookedSessions.remove(session.id);
    log(responseBodies.message);
  }

  Future<void> bookSession(
      ApiClient client, List<Membership> memberships, Session session) async {
    final responseBodies = await client.performRequest(Api.bookEvent(
        memberId: memberships.first.memberId,
        eventDate: session.date.toYearMonthDay,
        eventId: session.rawId));
    _cachedSessions[session.id]?.isBookedByMe = true;
    _bookedSessions.add(session.id);
    log(responseBodies.message);
    return;
  }

  List<Session> _getSessionsForIds(List<SessionId> sessionIds,
      {bool isSortedByDate = true}) {
    final sessions = sessionIds
        .map((e) => _cachedSessions[e])
        .where((element) => element != null)
        .map((e) => e as Session)
        .toList();

    if (isSortedByDate) {
      sessions.sort((a, b) => a.startTime.compareTo(b.startTime));
    }
    return sessions;
  }

  Future<void> _fetchSessionsFromDate(
      Date date, ApiClient client, List<Membership> memberships) async {
    final membership = memberships.first;
    final defaultLocationAreas = membership.facilities
        .firstWhere((facility) => facility.key == membership.defaultLocation)
        .areas;

    final responseBodies = await Future.wait(
        defaultLocationAreas.map((area) => client.performRequest(Api.getEvents(
              memberId: membership.memberId,
              date: date.toYearMonthDay,
              area: area.key,
            ))));

    final sessions = responseBodies
        .expand((element) => element.events)
        .map((e) => Session.fromEvent(e))
        .toList();

    _updateSessionDictionaryAndBookedSessions(sessions);
  }

  /// Updates sessions to _cachedSessions, _sessionDictionary and _bookSessions
  void _updateSessionDictionaryAndBookedSessions(List<Session> sessions) {
    for (var session in sessions) {
      _cachedSessions[session.id] = session;

      if (!_sessionsGroupedByDate.containsKey(session.date)) {
        _sessionsGroupedByDate[session.date] = {};
      }
      _sessionsGroupedByDate[session.date]?.add(session.id);

      if (session.isBookedByMe) {
        _bookedSessions.add(session.id);
      }
    }
  }

  List<Session> _filterPastBookedSessions() {
    final sessions =
        _getSessionsForIds(_bookedSessions.toList(), isSortedByDate: false)
            .where((element) => element.startTime.isBefore(DateTime.now()))
            .toList();
    return sessions;
  }

  List<Session> _filterFutureBookedSessions() {
    final sessions =
        _getSessionsForIds(_bookedSessions.toList(), isSortedByDate: false)
            .where((element) => element.startTime.isAfter(DateTime.now()))
            .toList();
    return sessions;
  }

  /// Returns the maximum bookable Date from a given DateTime
  Date _getMaximumBookableDate() {
    DateTime currentTime = DateTime.now();
    return currentTime.isBefore(DateTime(
            currentTime.year, currentTime.month, currentTime.day, 10, 15))
        ? Date.fromDateTime(currentTime.add(const Duration(days: 1)))
        : Date.fromDateTime(currentTime.add(const Duration(days: 2)));
  }
}
