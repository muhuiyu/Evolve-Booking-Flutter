class ClassDetails {
  final String area;
  final String level;
  final String facility;
  // final List<dynamic> instructors;
  final bool isBookedByMe;
  final bool isWaitingByMe;
  final bool isBookAvailable;
  final bool isWaitAvailable;
  final bool isConfirmBook;
  final bool isEarlyBookingAvailable;
  final bool isCP;
  final bool isFull;
  final bool isBookingAvailable;
  final bool isPast;
  final bool isHIIT;
  final bool isAttendable;
  final int waitlistPosition;
  final bool isGroupAttendance;
  final bool isZoom;

  ClassDetails._({
    required this.area,
    required this.level,
    required this.facility,
    // required this.instructors,
    required this.isBookedByMe,
    required this.isWaitingByMe,
    required this.isBookAvailable,
    required this.isWaitAvailable,
    required this.isConfirmBook,
    required this.isEarlyBookingAvailable,
    required this.isCP,
    required this.isFull,
    required this.isBookingAvailable,
    required this.isPast,
    required this.isHIIT,
    required this.isAttendable,
    required this.waitlistPosition,
    required this.isGroupAttendance,
    required this.isZoom,
  });

  factory ClassDetails.fromJson(Map<String, dynamic> json) {
    return ClassDetails._(
      area: json['area'],
      level: json['level'],
      facility: json['facility'],
      // instructors: json['instructors'],
      isBookedByMe: json['isBookedByMe'],
      isWaitingByMe: json['isWaitingByMe'],
      isBookAvailable: json['isBookAvailable'],
      isWaitAvailable: json['isWaitAvailable'],
      isConfirmBook: json['isConfirmBook'],
      isEarlyBookingAvailable: json['isEarlyBookingAvailable'],
      isCP: json['isCP'],
      isFull: json['isFull'],
      isBookingAvailable: json['isBookingAvailable'],
      isPast: json['isPast'],
      isHIIT: json['isHIIT'],
      isAttendable: json['isAttendable'],
      waitlistPosition: json['waitlistPosition'],
      isGroupAttendance: json['isGroupAttendance'],
      isZoom: json['isZoom'],
    );
  }
}
