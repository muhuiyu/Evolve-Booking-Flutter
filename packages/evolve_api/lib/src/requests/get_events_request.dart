import 'dart:convert';

import 'package:evolve_api/src/core/api_request.dart';
import 'package:evolve_api/src/models/event.dart';
import 'package:evolve_api/src/models/year_month_day.dart';

class GetEventsResponseBody {
  final List<Event> events;
  final int timeToNextBookingFrameInMillis;
  final DateTime date;

  GetEventsResponseBody._({
    required this.events,
    required this.timeToNextBookingFrameInMillis,
    required this.date,
  });

  factory GetEventsResponseBody.fromJson(Map<String, dynamic> json) {
    return GetEventsResponseBody._(
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeToNextBookingFrameInMillis: json['timeToNextBookingFrame'],
      date: DateTime.parse(json['date']),
    );
  }
}

enum GetEventsView {
  threeDaysWithCache;

  @override
  String toString() {
    switch (this) {
      case GetEventsView.threeDaysWithCache:
        return '3days+cache';
    }
  }
}

ApiRequest<GetEventsResponseBody> getEventsRequest({
  required String memberId,
  required YearMonthDay date,
  required String area,
  GetEventsView view = GetEventsView.threeDaysWithCache,
}) {
  return ApiRequest.get(
    path: '/booking/get-events',
    queryParameters: {
      'memberId': memberId,
      'date': date.toString(),
      'area': area,
      'view': view.toString(),
    },
    parseResponse: (response) =>
        GetEventsResponseBody.fromJson(jsonDecode(response.body)),
  );
}
