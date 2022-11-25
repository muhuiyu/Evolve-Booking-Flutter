import 'dart:convert';

import 'package:http/http.dart' show Request;

import 'api_request.dart';

class ApiRequestConfigurator {
  Request configureRequest(ApiRequest<dynamic> apiRequest) {
    final uri = Uri(
      scheme: 'https',
      host: 'api.evolvegenius.com',
      path: apiRequest.path,
      queryParameters: apiRequest.queryParameters,
    );

    final request = Request(
      apiRequest.method.toString(),
      uri,
    );
    request.headers.addAll({
      'Referer': 'https://book.evolve-mma.com/',
      'User-Agent':
          'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1'
    });
    final headers = apiRequest.headers ?? {};
    if (apiRequest.method.canHaveBody && apiRequest.jsonBody != null) {
      request.body = jsonEncode(apiRequest.jsonBody);
      if (!headers.containsKey('Content-Type')) {
        headers['Content-Type'] = 'application/json';
      }
    }
    if (headers.isNotEmpty) {
      request.headers.addAll(headers);
    }
    return request;
  }
}
