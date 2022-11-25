import 'area.dart';
import 'hour_minute.dart';

class Facility {
  final String key;
  final String name;
  final String shortName;
  final String title;
  final HourMinute openTime;
  final HourMinute closeTime;
  final List<Area> areas;

  Facility._({
    required this.key,
    required this.name,
    required this.shortName,
    required this.title,
    required this.openTime,
    required this.closeTime,
    required this.areas,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility._(
        key: json['key'],
        name: json['name'],
        shortName: json['shortName'],
        title: json['title'],
        openTime: HourMinute.fromJson(json['openTime']),
        closeTime: HourMinute.fromJson(json['closeTime']),
        areas: (json['areas'] as List)
            .map((e) => Area.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
