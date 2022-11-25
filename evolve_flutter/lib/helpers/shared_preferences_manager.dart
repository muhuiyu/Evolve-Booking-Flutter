import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static var shared = SharedPreferencesManager();

  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _kNotificationsPrefs = 'allowNotifications';
  final String _kSortingOrderPrefs = 'sortOrder';
  final String _kLanguageCode = 'languageCode';
  final String _kTimeFormat = 'timeFormat';

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  Future<bool> getAllowsNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kNotificationsPrefs) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  Future<bool> setAllowsNotifications(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kNotificationsPrefs, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  Future<String> getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kSortingOrderPrefs) ?? 'name';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  Future<bool> setSortingOrder(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kSortingOrderPrefs, value);
  }

  /// ------------------------------------------------------------
  /// Returns the user decision on language
  /// ------------------------------------------------------------
  Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kLanguageCode) ?? 'en';
  }

  /// ----------------------------------------------------------
  /// Saves the user decision on language
  /// ----------------------------------------------------------
  Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kLanguageCode, value);
  }

  /// ------------------------------------------------------------
  /// Returns the user decision on language
  /// ------------------------------------------------------------
  Future<String> getTimeFormat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kTimeFormat) ?? TimeFormat.civilian.name;
  }
  // Future<TimeFormat> getTimeFormat() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return TimeFormatExtension.fromString(prefs.getString(_kTimeFormat) ?? '');
  // }

  /// ----------------------------------------------------------
  /// Saves the user decision on language
  /// ----------------------------------------------------------
  Future<bool> setTimeFormat(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kLanguageCode, value);
  }
}

enum TimeFormat { civilian, military }

extension TimeFormatExtension on TimeFormat {
  String get name {
    switch (this) {
      case TimeFormat.civilian:
        return 'civilain';
      case TimeFormat.military:
        return 'military';
    }
  }

  static TimeFormat fromString(String string) {
    var timeFormat = TimeFormat.values.firstWhere(
      (element) => element.name == string,
      orElse: () => TimeFormat.civilian,
    );
    return timeFormat;
  }
}
