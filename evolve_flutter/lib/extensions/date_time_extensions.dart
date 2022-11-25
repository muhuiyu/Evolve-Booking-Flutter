import 'package:evolve_flutter/helpers/shared_preferences_manager.dart';

enum WeekdayStringFormat { short, normal, full }

extension DateTimeExtension on DateTime {
  String get getString {
    // final timeFormat = SharedPreferencesManager.shared.getTimeFormat();
    // for testing
    const timeFormat = TimeFormat.civilian;
    String hourString;
    String minuteString = minute < 10 ? '0$minute' : '$minute';
    String suffix = '';

    switch (timeFormat) {
      case TimeFormat.civilian:
        hourString = hour > 12 ? '${hour - 12}' : '$hour';
        suffix = hour < 12 ? 'AM' : 'PM';
        break;
      case TimeFormat.military:
        hourString = hour < 10 ? '0$hour' : '$hour';
        break;
    }
    return '$hourString:$minuteString $suffix';
  }

  int get toMinutes {
    return hour * 60 + minute;
  }

  String get toMonthDay {
    final monthDictionary = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    String monthString =
        (month >= 1 && month <= 12) ? monthDictionary[month] : '';

    // String dayString = day < 10 ? '0${day.toString()}' : day.toString();
    // return '$monthString $dayString';
    return '$monthString $day';
  }

  String _getWeekdayStringShort() {
    var weekDayDictionary = ['', 'M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return (weekday > 0 && weekday <= 7) ? weekDayDictionary[weekday] : '';
  }

  String _getWeekdayStringNormal() {
    var weekDayDictionary = [
      '',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ];
    return (weekday > 0 && weekday <= 7) ? weekDayDictionary[weekday] : '';
  }

  String _getWeekdayStringFull() {
    var weekDayDictionary = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return (weekday > 0 && weekday <= 7) ? weekDayDictionary[weekday] : '';
  }

  String getWeekdayString(WeekdayStringFormat format) {
    switch (format) {
      case WeekdayStringFormat.short:
        return _getWeekdayStringShort();
      case WeekdayStringFormat.normal:
        return _getWeekdayStringNormal();
      case WeekdayStringFormat.full:
        return _getWeekdayStringFull();
    }
  }
}
