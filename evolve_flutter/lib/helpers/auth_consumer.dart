import 'package:evolve_flutter/helpers/auth_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthConsumer extends StatelessWidget {
  const AuthConsumer({super.key, required this.builder});

  final Widget Function(BuildContext context, AuthContext auth) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthContext>(
      builder: (context, auth, child) {
        return builder(context, auth);
      },
    );
  }
}
