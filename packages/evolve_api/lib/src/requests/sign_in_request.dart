import 'dart:convert';

import 'package:evolve_api/src/core/api_request.dart';
import 'package:evolve_api/src/models/notification_method.dart';

class SignInResponseBody {
  final NotificationMethod mfaMethod;
  final bool secondFactorAuth;

  SignInResponseBody._({
    required this.mfaMethod,
    required this.secondFactorAuth,
  });

  factory SignInResponseBody.fromJson(Map<String, dynamic> json) {
    return SignInResponseBody._(
      mfaMethod: NotificationMethod.fromJson(json['mfaMethod']),
      secondFactorAuth: json['secondFactorAuth'],
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
