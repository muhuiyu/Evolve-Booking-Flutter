enum RenewalType {
  nmu;

  factory RenewalType.fromJson(String json) {
    switch (json) {
      case 'NMU':
        return RenewalType.nmu;
      default:
        throw ArgumentError('Invalid RenewalType: $json');
    }
  }
}
