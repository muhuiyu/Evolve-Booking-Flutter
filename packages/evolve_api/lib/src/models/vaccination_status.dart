enum VaccinationStatus {
  unknown,
  fullyVaccinatedWithoutBooster,
  fullyVaccinatedWith1stBooster,
  notEligibleForVaccination,
  notTakingTheVaccine,
  awaiting2ndDoseOrAwaitingFullyVaccinatedStatus,
  recoveredFromCovid19;

  factory VaccinationStatus.fromJson(String json) {
    switch (json) {
      case 'FULLY_VACCINATED_WITHOUT_BOOSTER':
        return VaccinationStatus.fullyVaccinatedWithoutBooster;
      case 'FULLY_VACCINATED_WITH_1ST_BOOSTER':
        return VaccinationStatus.fullyVaccinatedWith1stBooster;
      case 'NOT_ELIGIBLE_FOR_VACCINATION':
        return VaccinationStatus.notEligibleForVaccination;
      case 'NOT_TAKING_THE_VACCINE':
        return VaccinationStatus.notTakingTheVaccine;
      case 'AWAITING_2ND_DOSE_OR_AWAITING_FULLY_VACCINATED_STATUS':
        return VaccinationStatus.awaiting2ndDoseOrAwaitingFullyVaccinatedStatus;
      case 'RECOVERED_FROM_COVID_19':
        return VaccinationStatus.recoveredFromCovid19;
      default:
        return VaccinationStatus.unknown;
    }
  }
}
