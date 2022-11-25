enum NotificationMethod {
  sms,
  email;

  factory NotificationMethod.fromJson(String value) {
    switch (value) {
      case 'SMS':
        return NotificationMethod.sms;
      case 'EMAIL':
        return NotificationMethod.email;
      default:
        throw Exception('Unknown NotificationMethod: $value');
    }
  }
}
