enum EventRecurrenceFrequency {
  weekly;

  @override
  String toString() {
    return name.toUpperCase();
  }

  factory EventRecurrenceFrequency.fromJson(String value) {
    switch (value) {
      case 'WEEKLY':
        return EventRecurrenceFrequency.weekly;
      default:
        throw Exception('Unknown event recurrence type: $value');
    }
  }
}

abstract class EventRecurrence {
  abstract final EventRecurrenceFrequency frequency;

  EventRecurrence._();

  factory EventRecurrence.fromJson(Map<String, dynamic> json) {
    switch (EventRecurrenceFrequency.fromJson(json['frequency'])) {
      case EventRecurrenceFrequency.weekly:
        return WeeklyEventRecurrence._fromJson(json);
      default:
        throw Exception('Unknown event recurrence type: ${json['frequency']}');
    }
  }
}

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  factory WeekDay.fromJson(String json) {
    switch (json) {
      case "MO":
        return WeekDay.monday;
      case "TU":
        return WeekDay.tuesday;
      case "WE":
        return WeekDay.wednesday;
      case "TH":
        return WeekDay.thursday;
      case "FR":
        return WeekDay.friday;
      case "SA":
        return WeekDay.saturday;
      case "SU":
        return WeekDay.sunday;
      default:
        throw Exception('Unknown week day: $json');
    }
  }
}

class WeeklyEventRecurrence extends EventRecurrence {
  final List<WeekDay> weekDays;

  WeeklyEventRecurrence._({
    required this.weekDays,
  }) : super._();

  @override
  final EventRecurrenceFrequency frequency = EventRecurrenceFrequency.weekly;

  factory WeeklyEventRecurrence._fromJson(Map<String, dynamic> json) {
    assert(EventRecurrenceFrequency.fromJson(json['frequency']) ==
        EventRecurrenceFrequency.weekly);
    return WeeklyEventRecurrence._(
      weekDays: (json['weekDays'] as List<dynamic>)
          .map((json) => WeekDay.fromJson(json))
          .toList(),
    );
  }
}
