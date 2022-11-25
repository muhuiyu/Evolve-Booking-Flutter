import 'package:evolve_api/src/core/api_request_configurator.dart';
import 'package:http/http.dart';

import 'api_request.dart';

class ApiClient {
  final ApiRequestConfigurator requestConfigurator;

  ApiClient({required this.requestConfigurator});

  Future<TResponseBody> performRequest<TResponseBody>(
      ApiRequest<TResponseBody> request) async {
    final networkRequest = requestConfigurator.configureRequest(request);
    final streamedResponse = await networkRequest.send();
    final response = await Response.fromStream(streamedResponse);
    if (streamedResponse.statusCode >= 200 &&
        streamedResponse.statusCode < 300) {
      return request.parseResponse(response);
    } else {
      throw Exception(
          'Request failed with status code ${streamedResponse.statusCode}: ${response.body}');
    }
  }
}
