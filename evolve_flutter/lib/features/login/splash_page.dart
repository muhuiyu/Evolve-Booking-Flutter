import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/features/core/main_tab_controller.dart';
import 'package:evolve_flutter/features/login/login_page.dart';
import 'package:evolve_flutter/helpers/auth_storage.dart';
import 'package:evolve_flutter/widgets/mount_observer.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _determineNavigation(ApiClient client) async {
    var token = await AuthStorage.shared.getToken();
    if (token == null) {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      }
      return;
    }
    final List<Membership> memberships;
    try {
      memberships =
          await client.performRequest(Api.getMemberships(token: token));
    } catch (error) {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      }
      return;
    }
    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            MainTabController(token: token, memberships: memberships),
      ));
    }
  }

  _onMount(ApiClient client) {
    _determineNavigation(client);
  }

  @override
  Widget build(BuildContext context) {
    return ApiClientConsumer(
      builder: (context, apiClient) => MountObserver(
          onMount: () => _onMount(apiClient),
          child: Container(
            color: Colors.red,
            child: const Text('hello'),
          )),
    );
  }
}
