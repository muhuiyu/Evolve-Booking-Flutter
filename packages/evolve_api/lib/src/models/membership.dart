import 'facility.dart';
import 'notification_method.dart';
import 'renewal_type.dart';
import 'vaccination_status.dart';

class Membership {
  final String id;
  final String memberId;
  final NotificationMethod mfaMethod;
  final NotificationMethod waitlistNotificationMethod;
  final String defaultLocation;
  final String program;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final bool autoBook;
  final bool? addBuddy;
  final List<Facility> facilities;
  final bool isEmployee;
  final bool accessToRegularClasses;
  final RenewalType renewalType;
  final List<dynamic> group;
  final String? groupPartnerId;
  final VaccinationStatus vaccinationStatus;

  Membership._({
    required this.id,
    required this.memberId,
    required this.mfaMethod,
    required this.waitlistNotificationMethod,
    required this.defaultLocation,
    required this.program,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.autoBook,
    required this.addBuddy,
    required this.facilities,
    required this.isEmployee,
    required this.accessToRegularClasses,
    required this.renewalType,
    required this.group,
    required this.groupPartnerId,
    required this.vaccinationStatus,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership._(
        id: json['id'],
        memberId: json['memberId'],
        mfaMethod: NotificationMethod.fromJson(json['mfaMethod']),
        waitlistNotificationMethod:
            NotificationMethod.fromJson(json['waitlistNotificationMethod']),
        defaultLocation: json['defaultLocation'],
        program: json['program'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        mobile: json['mobile'],
        autoBook: json['autoBook'],
        addBuddy: json['addBuddy'],
        facilities: (json['facilities'] as List)
            .map((e) => Facility.fromJson(e as Map<String, dynamic>))
            .toList(),
        isEmployee: json['isEmployee'],
        accessToRegularClasses: json['accessToRegularClasses'],
        renewalType: RenewalType.fromJson(json['renewalType']),
        group: json['group'],
        groupPartnerId: json['groupPartnerId'],
        vaccinationStatus:
            VaccinationStatus.fromJson(json['vaccinationStatus']));
  }
}
