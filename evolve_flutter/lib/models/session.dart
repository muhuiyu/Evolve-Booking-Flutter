import 'dart:developer';

import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/text_constants.dart';
import 'package:evolve_flutter/extensions/date_time_extensions.dart';
import 'package:evolve_flutter/models/date.dart';
import 'package:evolve_flutter/models/session_details.dart';
import 'package:evolve_flutter/models/session_location.dart';

typedef SessionId = String;

enum SessionAction { book, cancel }

class Session {
  SessionId id;
  SessionId rawId;
  SessionDetails details;
  SessionLocation location;
  DateTime startTime;
  Duration duration;
  bool isBookedByMe;

  Session({
    required this.id,
    required this.rawId,
    required this.details,
    required this.location,
    required this.startTime,
    required this.duration,
    required this.isBookedByMe,
  });

  factory Session.fromEvent(Event event) {
    final startTime = DateTime(
        event.start.year,
        event.start.month,
        event.start.day,
        event.details.startTime.hour,
        event.details.startTime.minute);
    final details =
        SessionDetails.fromRawLevelString(event.details.classDetails.level);

    SessionLocation location =
        SessionLocationExtensions.getFromCode(event.details.area);

    final sessionId = '${event.details.id}-${startTime.month}-${startTime.day}';

    return Session(
      id: sessionId,
      rawId: event.details.id,
      details: details,
      location: location,
      startTime: startTime,
      duration: Duration(minutes: event.details.durationInMinutes),
      isBookedByMe: event.details.classDetails.isBookedByMe,
    );
  }

  bool get isBookingAvailable {
    DateTime newDate = DateTime.now().add(const Duration(days: 2));
    DateTime newDateTime =
        DateTime(newDate.year, newDate.month, newDate.day, 0, 0, 0);
    return startTime.isAfter(DateTime.now()) && startTime.isBefore(newDateTime);
  }

  bool get isSessionEnded {
    return startTime.isAfter(DateTime.now());
  }

  Date get date {
    return Date(
        year: startTime.year, month: startTime.month, day: startTime.day);
  }

  DateTime get endTime {
    return startTime.add(duration);
  }

  String get name {
    return details.name;
  }

  String get getDurationString {
    int durationInMinutes = duration.inMinutes;
    return '$durationInMinutes min';
    // if (durationInMinutes > 60) {
    //   return '${(durationInMinutes / 60).floor()} hr ${durationInMinutes % 60} min';
    // } else {
    //   return '$durationInMinutes min';
    // }
  }

  String get getBookingConfirmationTimeDurationString {
    return '${startTime.getWeekdayString(WeekdayStringFormat.normal)}, ${startTime.toMonthDay}, ${startTime.getString} - ${endTime.getString}';
  }

  // Returns true if [this.startTime] occurs in weekday morning (Class Start Time: 6.30-7.45 AM)
  bool get _isWeekdayMorningClasses {
    if (startTime.weekday == 6 || startTime.weekday == 7) {
      return false;
    }
    return startTime.isBefore(
        DateTime(startTime.year, startTime.month, startTime.day, 7, 46));
  }

  // Returns true if [this.startTime] occurs in weekday peak hours (Class Start Time: 12-12.45 PM and 6-8.45 PM)
  bool get _isWeekdayPeakHour {
    if (startTime.weekday == 6 || startTime.weekday == 7) {
      return false;
    } else if (startTime.isAfter(
            DateTime(startTime.year, startTime.month, startTime.day, 11, 59)) &&
        startTime.isBefore(
            DateTime(startTime.year, startTime.month, startTime.day, 12, 46))) {
      return true;
    } else if (startTime.isAfter(
            DateTime(startTime.year, startTime.month, startTime.day, 17, 59)) &&
        startTime.isBefore(
            DateTime(startTime.year, startTime.month, startTime.day, 20, 46))) {
      return true;
    }
    return false;
  }

  String get getCancellationText {
    if (isWithinCancellationWindow) {
      return TextConstant.bookingConfirmationCancelWarnings;
    }
    if (_isWeekdayMorningClasses) {
      return 'Cancel before 10 PM the night before in advance to avoid penalty.';
    } else if (_isWeekdayPeakHour) {
      return 'Cancel 6 hours in advance to avoid penalty.';
    } else {
      return 'Cancel 3 hours in advance to avoid penalty.';
    }
  }

  bool get isWithinCancellationWindow {
    var currentTime = DateTime.now();
    log('$currentTime, $startTime');
    if (currentTime.isAfter(startTime)) {
      return false;
    }

    if (_isWeekdayMorningClasses) {
      var previousDay = startTime.add(const Duration(days: -1));
      return currentTime.isAfter(DateTime(
          previousDay.year, previousDay.month, previousDay.day, 22, 0));
    } else if (_isWeekdayPeakHour) {
      return currentTime.isAfter(startTime.add(const Duration(hours: -6)));
    } else {
      // For all other classes, you may cancel your booking up to 3 hours before the start of the class.
      return currentTime.isAfter(startTime.add(const Duration(hours: -3)));
    }
  }
}
