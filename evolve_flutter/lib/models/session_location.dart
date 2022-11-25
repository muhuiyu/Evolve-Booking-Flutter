enum SessionLocation {
  fesWarrior,
  fesLegend,
  fesChampion,
  locationDictionary,
}

extension SessionLocationExtensions on SessionLocation {
  static SessionLocation getFromCode(String code) {
    final locationDictionary = {
      SessionLocation.fesWarrior.code: SessionLocation.fesWarrior,
      SessionLocation.fesLegend.code: SessionLocation.fesLegend,
      SessionLocation.fesChampion.code: SessionLocation.fesChampion,
    };
    return locationDictionary[code] ?? SessionLocation.fesWarrior;
  }

  String get fullName {
    final nameDictionary = {
      SessionLocation.fesWarrior: 'FarEast Warrior',
      SessionLocation.fesLegend: 'FarEast Legend',
      SessionLocation.fesChampion: 'FarEast Champion',
    };
    return nameDictionary[this] ?? '';
  }

  String get code {
    final codeDictionary = {
      SessionLocation.fesWarrior: 'FES_WARRIOR',
      SessionLocation.fesLegend: 'FES_LEGEND',
      SessionLocation.fesChampion: 'FES_CHAMPION',
    };
    return codeDictionary[this] ?? '';
  }
}
