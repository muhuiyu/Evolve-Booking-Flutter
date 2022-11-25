import 'dart:convert';

import 'package:evolve_api/src/core/api_request.dart';
import 'package:evolve_api/src/models/membership.dart';

ApiRequest<List<Membership>> getMembershipsRequest({String? token}) {
  return ApiRequest.get(
    path: '/booking/get-memberships',
    headers: token != null ? {'Authorization': 'Bearer $token'} : null,
    parseResponse: (response) => (jsonDecode(response.body) as List<dynamic>)
        .map((e) => Membership.fromJson(e))
        .toList(),
  );
}
