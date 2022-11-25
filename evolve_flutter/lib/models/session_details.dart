import 'package:evolve_flutter/models/session_category.dart';
import 'package:evolve_flutter/models/session_level.dart';

class SessionDetails {
  String name;
  SessionCategory category;
  SessionLevel level;

  SessionDetails({
    required this.name,
    required this.category,
    required this.level,
  });

  factory SessionDetails.fromRawLevelString(String levelString) {
    // if (levelString.startsWith('MT')) {

    // }

    final sessionDictionary = {
      'MT_WOMEN': SessionDetails(
          name: 'Muay Thai (Women)',
          category: SessionCategory.muayThai,
          level: SessionLevel.beginner),
      'MT_LEVEL_1': SessionDetails(
          name: 'Muay Thai I',
          category: SessionCategory.muayThai,
          level: SessionLevel.beginner),
      'MT_LEVEL_2': SessionDetails(
          name: 'Muay Thai II',
          category: SessionCategory.muayThai,
          level: SessionLevel.intermediate),
      'MT_LEVEL_3': SessionDetails(
          name: 'Muay Thai I',
          category: SessionCategory.muayThai,
          level: SessionLevel.advanced),
      'MT_SPARRING': SessionDetails(
          name: 'Muay Thai Sparring',
          category: SessionCategory.muayThai,
          level: SessionLevel.advanced),
      'MT_CLINCHING': SessionDetails(
          name: 'Muay Thai Clunching',
          category: SessionCategory.muayThai,
          level: SessionLevel.advanced),
      'BOXING_LEVEL_1': SessionDetails(
          name: 'Boxing I',
          category: SessionCategory.boxing,
          level: SessionLevel.beginner),
      'BOXING_LEVEL_2': SessionDetails(
          name: 'Boxing II',
          category: SessionCategory.boxing,
          level: SessionLevel.intermediate),
      'BOXING_LEVEL_3': SessionDetails(
          name: 'Boxing III',
          category: SessionCategory.boxing,
          level: SessionLevel.advanced),
      'BJJ_BLUE': SessionDetails(
          name: 'Bjj Blue',
          category: SessionCategory.bjj,
          level: SessionLevel.beginner),
      'BJJ_PURLE': SessionDetails(
          name: 'Bjj Purple',
          category: SessionCategory.bjj,
          level: SessionLevel.intermediate),
      'BJJ_RANDORI': SessionDetails(
          name: 'Bjj Randori',
          category: SessionCategory.bjj,
          level: SessionLevel.advanced),
      'BJJ_NOGI': SessionDetails(
          name: 'Bjj Nogi',
          category: SessionCategory.bjj,
          level: SessionLevel.advanced),
      'WARRIOR_FIT': SessionDetails(
          name: 'Warrior Fit I',
          category: SessionCategory.warriorFit,
          level: SessionLevel.beginner),
      'WARRIOR_FIT_2': SessionDetails(
          name: 'Warrior Fit II',
          category: SessionCategory.warriorFit,
          level: SessionLevel.intermediate),
      'MMA': SessionDetails(
          name: 'MMA', category: SessionCategory.mma, level: SessionLevel.all),
      'WRESTLING': SessionDetails(
          name: 'Wrestling',
          category: SessionCategory.wrestling,
          level: SessionLevel.all),
    };

    return sessionDictionary[levelString] ??
        SessionDetails.defaultSessionDetails;
  }

  static SessionDetails defaultSessionDetails = SessionDetails(
      name: 'Boxing I',
      category: SessionCategory.boxing,
      level: SessionLevel.beginner);
}
