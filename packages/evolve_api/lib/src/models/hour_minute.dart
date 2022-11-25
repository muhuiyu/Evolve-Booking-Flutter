class HourMinute {
  final int hour;
  final int minute;

  HourMinute._(this.hour, this.minute);

  factory HourMinute.fromJson(List<dynamic> json) {
    if (json.length != 2) {
      throw ArgumentError('Invalid [hour, minute] value: $json');
    }
    return HourMinute._(json[0] as int, json[1] as int);
  }
}
