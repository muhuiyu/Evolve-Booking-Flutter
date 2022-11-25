import 'dart:ui';

import 'api_color.dart';

class Area {
  final String key;
  final String name;
  final String shortName;
  final Color background;
  final Color color;
  final bool? isHIIT;
  final bool? isZoom;

  Area._({
    required this.key,
    required this.name,
    required this.shortName,
    required this.background,
    required this.color,
    required this.isHIIT,
    required this.isZoom,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area._(
        key: json['key'],
        name: json['name'],
        shortName: json['shortName'],
        background: ApiColor.fromJson(json['background']),
        color: ApiColor.fromJson(json['color']),
        isHIIT: json['isHIIT'],
        isZoom: json['isZoom']);
  }
}
