import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class ApiColor extends Color {
  ApiColor._(super.value);

  factory ApiColor.fromJson(String json) {
    String hex = json.startsWith('#') ? json.substring(1) : json;
    switch (hex.length) {
      case 3:
        hex = 'ff${hex.split('').map((c) => c + c).join()}';
        break;
      case 6:
        hex = 'ff$hex';
        break;
      case 8:
        break;
      default:
        throw ArgumentError('Invalid hex color: $json');
    }
    return ApiColor._(int.parse(hex, radix: 16));
  }
}
