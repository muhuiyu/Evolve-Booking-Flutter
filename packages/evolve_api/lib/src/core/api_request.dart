import 'package:evolve_api/src/core/http_method.dart';
import 'package:http/http.dart';

class ApiRequest<TResponseBody> {
  final HttpMethod method;
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Map<String, String>? headers;
  final dynamic jsonBody;
  final TResponseBody Function(Response response) parseResponse;

  ApiRequest._({
    required this.method,
    required this.path,
    this.queryParameters,
    this.headers,
    this.jsonBody,
    required this.parseResponse,
  });

  factory ApiRequest.get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required TResponseBody Function(Response response) parseResponse,
  }) {
    return ApiRequest._(
      method: HttpMethod.get,
      path: path,
      queryParameters: queryParameters,
      headers: headers,
      parseResponse: parseResponse,
    );
  }

  factory ApiRequest.post({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic jsonBody,
    required TResponseBody Function(Response response) parseResponse,
  }) {
    return ApiRequest._(
      method: HttpMethod.post,
      path: path,
      queryParameters: queryParameters,
      headers: jsonBody != null
          ? {
              if (headers != null) ...headers,
              'Content-Type': 'application/json'
            }
          : headers,
      jsonBody: jsonBody,
      parseResponse: parseResponse,
    );
  }

  factory ApiRequest.put({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic jsonBody,
    required TResponseBody Function(Response response) parseResponse,
  }) {
    return ApiRequest._(
        method: HttpMethod.put,
        path: path,
        queryParameters: queryParameters,
        headers: jsonBody != null
            ? {
                if (headers != null) ...headers,
                'Content-Type': 'application/json'
              }
            : headers,
        jsonBody: jsonBody,
        parseResponse: parseResponse);
  }

  factory ApiRequest.patch({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    dynamic jsonBody,
    required TResponseBody Function(Response response) parseResponse,
  }) {
    return ApiRequest._(
        method: HttpMethod.patch,
        path: path,
        queryParameters: queryParameters,
        headers: jsonBody != null
            ? {
                if (headers != null) ...headers,
                'Content-Type': 'application/json'
              }
            : headers,
        jsonBody: jsonBody,
        parseResponse: parseResponse);
  }

  factory ApiRequest.delete({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required TResponseBody Function(Response response) parseResponse,
  }) {
    return ApiRequest._(
        method: HttpMethod.delete,
        path: path,
        queryParameters: queryParameters,
        headers: headers,
        parseResponse: parseResponse);
  }
}
