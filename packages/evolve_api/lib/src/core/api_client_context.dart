import 'package:evolve_api/src/core/api_client.dart';
import 'package:flutter/foundation.dart';

import 'api_request_configurator.dart';

class ApiClientContext extends ChangeNotifier {
  ApiClient _apiClient;
  ApiClient get apiClient => _apiClient;

  ApiClientContext({required ApiRequestConfigurator requestConfigurator})
      : _apiClient = ApiClient(requestConfigurator: requestConfigurator);

  void changeRequestConfigurator(ApiRequestConfigurator requestConfigurator) {
    _apiClient = ApiClient(requestConfigurator: requestConfigurator);
    notifyListeners();
  }
}
