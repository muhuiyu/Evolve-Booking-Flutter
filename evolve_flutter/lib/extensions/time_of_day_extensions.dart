import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  String get getString {
    if (minute < 10) {
      return hour < 10 ? '0$hour:0$minute' : '$hour:0$minute';
    } else {
      return '$hour:$minute';
    }
  }

  int get toMinutes {
    return hour * 60 + minute;
  }
}
