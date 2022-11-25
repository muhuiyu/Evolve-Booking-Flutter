class CustomTimeOfDay {
  final int hour;
  final int minute;

  CustomTimeOfDay._({
    required this.hour,
    required this.minute,
  });

  factory CustomTimeOfDay.fromJson(int json) {
    return CustomTimeOfDay._(
      hour: json ~/ 60,
      minute: json % 60,
    );
  }
}
