import 'dart:convert';

import 'package:evolve_api/src/core/api_request.dart';
import 'package:evolve_api/src/models/membership.dart';

class VerifyCodeResponseBody {
  final String token;
  final List<Membership> memberships;

  VerifyCodeResponseBody._({
    required this.token,
    required this.memberships,
  });

  factory VerifyCodeResponseBody.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponseBody._(
      token: json['token'],
      memberships: (json['memberships'] as List<dynamic>)
          .map((e) => Membership.fromJson(e))
          .toList(),
    );
  }
}

ApiRequest<VerifyCodeResponseBody> verifyCodeRequest({
  required String email,
  required String password,
  bool forceEmailMfa = false,
  bool rememberMe = true,
  required String verificationCode,
}) {
  return ApiRequest.post(
    path: '/booking/sessions',
    jsonBody: {
      'forceEmailMFA': forceEmailMfa,
      'login': email,
      'password': password,
      'rememberMe': rememberMe,
      'verificationCode': verificationCode,
    },
    parseResponse: (response) =>
        VerifyCodeResponseBody.fromJson(jsonDecode(response.body)),
  );
}
