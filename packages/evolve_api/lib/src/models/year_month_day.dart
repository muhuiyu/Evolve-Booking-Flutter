class YearMonthDay {
  final int year;
  final int month;
  final int day;

  YearMonthDay({required this.year, required this.month, required this.day});

  factory YearMonthDay.fromJson(String json) {
    final components = json.split('-');
    if (components.length != 3) {
      throw ArgumentError('Invalid YYYY-MM-DD value: $json');
    }
    return YearMonthDay(
      year: int.parse(components[0]),
      month: int.parse(components[1]),
      day: int.parse(components[2]),
    );
  }

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }

  @override
  String toString() {
    final yearString = year.toString().padLeft(4, '0');
    final monthString = month.toString().padLeft(2, '0');
    final dayString = day.toString().padLeft(2, '0');
    return '$yearString-$monthString-$dayString';
  }

  static YearMonthDay today() {
    final now = DateTime.now();
    return YearMonthDay(
      year: now.year,
      month: now.month,
      day: now.day,
    );
  }


  
}
