import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../core/api_client.dart';
import '../core/api_client_context.dart';

class ApiClientConsumer extends StatelessWidget {
  const ApiClientConsumer({super.key, required this.builder});

  final Widget Function(BuildContext context, ApiClient apiClient) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiClientContext>(
      builder: (context, apiClientContext, child) {
        return builder(context, apiClientContext.apiClient);
      },
    );
  }
}
