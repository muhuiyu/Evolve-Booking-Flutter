import 'dart:convert';
import 'package:evolve_api/evolve_api.dart';

enum SignInResponseBodyType {
  mfa,
  session;
}

abstract class SignInResponseBody {
  final SignInResponseBodyType type;

  SignInResponseBody({required this.type});

  factory SignInResponseBody.fromJson(Map<String, dynamic> json) {
    if (json['token'] != null) {
      return SignInSessionResponseBody.fromJson(json);
    } else {
      return SignInMfaResponseBody.fromJson(json);
    }
  }
}

class SignInMfaResponseBody extends SignInResponseBody {
  final NotificationMethod mfaMethod;
  final bool secondFactorAuth;

  SignInMfaResponseBody._({
    required this.mfaMethod,
    required this.secondFactorAuth,
  }) : super(type: SignInResponseBodyType.mfa);

  factory SignInMfaResponseBody.fromJson(Map<String, dynamic> json) {
    return SignInMfaResponseBody._(
      mfaMethod: NotificationMethod.fromJson(json['mfaMethod']),
      secondFactorAuth: json['secondFactorAuth'],
    );
  }
}

class SignInSessionResponseBody extends SignInResponseBody {
  final String token;
  final List<Membership> memberships;

  SignInSessionResponseBody._({
    required this.token,
    required this.memberships,
  }) : super(type: SignInResponseBodyType.session);

  factory SignInSessionResponseBody.fromJson(Map<String, dynamic> json) {
    return SignInSessionResponseBody._(
      token: json['token'],
      memberships: (json['memberships'] as List<dynamic>)
          .map((e) => Membership.fromJson(e))
          .toList(),
    );
  }
}

ApiRequest<SignInResponseBody> signInRequest({
  required String email,
  required String password,
  bool forceEmailMfa = false,
  bool rememberMe = true,
}) {
  return ApiRequest.post(
    path: '/booking/sessions',
    jsonBody: {
      'forceEmailMFA': forceEmailMfa,
      'login': email,
      'password': password,
      'rememberMe': rememberMe,
    },
    parseResponse: (response) =>
        SignInResponseBody.fromJson(jsonDecode(response.body)),
  );
}
