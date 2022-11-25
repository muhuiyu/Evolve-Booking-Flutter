import 'package:equatable/equatable.dart';
import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/extensions/date_time_extensions.dart';

class Date extends Equatable {
  final int year;
  final int month;
  final int day;

  const Date({required this.year, required this.month, required this.day});

  factory Date.fromDateTime(DateTime dateTime) {
    return Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);
  }

  factory Date.fromYearMonthDay(YearMonthDay yearMonthDay) {
    return Date(
        year: yearMonthDay.year,
        month: yearMonthDay.month,
        day: yearMonthDay.day);
  }

  static Date today = Date.fromDateTime(DateTime.now());

  YearMonthDay get toYearMonthDay {
    return YearMonthDay(year: year, month: month, day: day);
  }

  isBefore(Date date) {
    return toDateTime.isBefore(date.toDateTime);
  }

  isAfter(Date date) {
    return toDateTime.isAfter(date.toDateTime);
  }

  @override
  List<Object?> get props => [year, month, day];

  String get weekdayAndDay {
    return '${getWeekdayAbbreviation(WeekdayStringFormat.normal)} ${day.toString()}';
  }

  String getWeekdayAbbreviation(WeekdayStringFormat format) {
    var originalDate = DateTime(year, month, day);
    return originalDate.getWeekdayString(format);
  }

  Date add(Duration duration) {
    var originalDate = DateTime(year, month, day);
    var newDate = originalDate.add(duration);
    return Date(year: newDate.year, month: newDate.month, day: newDate.day);
  }

  static Date init(DateTime dateTime) {
    return Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);
  }

  DateTime get toDateTime {
    return DateTime(year, month, day);
  }
}
