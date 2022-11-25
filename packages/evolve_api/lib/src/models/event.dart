import 'dart:ui';

import 'package:evolve_api/src/models/api_color.dart';
import 'package:evolve_api/src/models/class_details.dart';
import 'package:evolve_api/src/models/event_recurrence.dart';
import 'package:evolve_api/src/models/time_of_day.dart';
import 'package:evolve_api/src/models/year_month_day.dart';

enum EventType {
  classSchedule;

  factory EventType.fromJson(String value) {
    switch (value) {
      case 'CLASS_SCHEDULE':
        return EventType.classSchedule;
      default:
        throw Exception('Unknown event type: $value');
    }
  }
}

class EventDetails {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? title;
  final EventType eventType;
  final YearMonthDay startDate;
  final YearMonthDay? endDate;
  final CustomTimeOfDay startTime;
  final int durationInMinutes;
  final EventRecurrence recurrence;
  final int maxAttendanceCount;
  final bool vaccination;
  final String facility;
  final String area;
  final ClassDetails classDetails;
  // final dynamic leaveDetails;
  // final dynamic unlimitedLeaveDetails;
  // final dynamic blockDetails;
  // final dynamic fightRestDetails;
  // final dynamic cornermanDetails;
  // final dynamic privateClassDetails;
  // final dynamic trialClassDetails;
  final DateTime? deletedAt;

  EventDetails._({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.title,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.durationInMinutes,
    required this.recurrence,
    required this.maxAttendanceCount,
    required this.vaccination,
    required this.facility,
    required this.area,
    required this.classDetails,
    // required this.leaveDetails,
    // required this.unlimitedLeaveDetails,
    // required this.blockDetails,
    // required this.fightRestDetails,
    // required this.cornermanDetails,
    // required this.privateClassDetails,
    // required this.trialClassDetails,
    required this.deletedAt,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails._(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      id: json['id'],
      title: json['title'],
      eventType: EventType.fromJson(json['type']),
      startDate: YearMonthDay.fromJson(json['startDate']),
      endDate: json['endDate'] != null
          ? YearMonthDay.fromJson(json['endDate'])
          : null,
      startTime: CustomTimeOfDay.fromJson(json['startTime']),
      durationInMinutes: json['duration'],
      recurrence: EventRecurrence.fromJson(json['recurrence']),
      maxAttendanceCount: json['maxAttendanceCount'],
      vaccination: json['vaccination'],
      facility: json['facility'],
      area: json['area'],
      classDetails: ClassDetails.fromJson(json['classDetails']),
      // leaveDetails: json['leaveDetails'],
      // unlimitedLeaveDetails: json['unlimitedLeaveDetails'],
      // blockDetails: json['blockDetails'],
      // fightRestDetails: json['fightRestDetails'],
      // cornermanDetails: json['cornermanDetails'],
      // privateClassDetails: json['privateClassDetails'],
      // trialClassDetails: json['trialClassDetails'],
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}

class EventStyle {
  final Color color;
  final Color backgroundColor;

  EventStyle._({
    required this.color,
    required this.backgroundColor,
  });

  factory EventStyle.fromJson(Map<String, dynamic> json) {
    return EventStyle._(
      color: ApiColor.fromJson(json['color']),
      backgroundColor: ApiColor.fromJson(json['backgroundColor']),
    );
  }
}

class EventProps {
  final EventStyle style;

  EventProps._({
    required this.style,
  });

  factory EventProps.fromJson(Map<String, dynamic> json) {
    return EventProps._(
      style: EventStyle.fromJson(json['style']),
    );
  }
}

class Event {
  final YearMonthDay date;
  final DateTime start;
  final DateTime end;
  final String title;
  final String resourceId;
  final EventDetails details;
  final EventProps props;

  Event._({
    required this.date,
    required this.start,
    required this.end,
    required this.title,
    required this.resourceId,
    required this.details,
    required this.props,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event._(
      date: YearMonthDay.fromJson(json['date']),
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      title: json['title'],
      resourceId: json['resourceId'],
      details: EventDetails.fromJson(json['event']),
      props: EventProps.fromJson(json['props']),
    );
  }
}
