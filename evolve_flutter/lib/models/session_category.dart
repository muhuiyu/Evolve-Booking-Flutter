import 'package:evolve_flutter/models/session_level.dart';
import 'package:flutter/material.dart';

enum SessionCategory { muayThai, boxing, mma, bjj, warriorFit, wrestling }

extension SessionCategoryExtension on SessionCategory {
  String get name {
    final nameDictionary = {
      SessionCategory.muayThai: 'Muay Thai',
      SessionCategory.boxing: 'Boxing',
      SessionCategory.mma: 'MMA',
      SessionCategory.bjj: 'BJJ',
      SessionCategory.warriorFit: 'Warrior Fit',
      SessionCategory.wrestling: 'Wrestling',
    };
    return nameDictionary[this] ?? '';
  }

  Color getColor(SessionLevel level) {
    switch (this) {
      case SessionCategory.muayThai:
        switch (level) {
          case SessionLevel.beginner:
            return Colors.grey;
          case SessionLevel.intermediate:
            return Colors.red;
          case SessionLevel.advanced:
            return Colors.lightGreen;
          default:
            return Colors.grey;
        }
      case SessionCategory.boxing:
        switch (level) {
          case SessionLevel.beginner:
            return Colors.green;
          case SessionLevel.intermediate:
            return Colors.brown;
          default:
            return Colors.green;
        }
      case SessionCategory.mma:
        return Colors.deepPurpleAccent;
      case SessionCategory.bjj:
        switch (level) {
          case SessionLevel.beginner:
            return Colors.blue;
          case SessionLevel.intermediate:
            return Colors.purple;
          default:
            return Colors.blue;
        }
      case SessionCategory.warriorFit:
        switch (level) {
          case SessionLevel.beginner:
            return Colors.yellow;
          case SessionLevel.intermediate:
            return Colors.orange;
          default:
            return Colors.yellow;
        }
      case SessionCategory.wrestling:
        return Colors.brown;
    }
  }
}
