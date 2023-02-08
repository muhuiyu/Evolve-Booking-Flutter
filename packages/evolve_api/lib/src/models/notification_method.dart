enum NotificationMethod {
  sms,
  email,
  none;

  factory NotificationMethod.fromJson(String value) {
    switch (value) {
      case 'SMS':
        return NotificationMethod.sms;
      case 'EMAIL':
        return NotificationMethod.email;
      case 'NONE':
        return NotificationMethod.none;
      default:
        throw Exception('Unknown NotificationMethod: $value');
    }
  }
}
