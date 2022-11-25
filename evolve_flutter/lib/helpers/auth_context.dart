import 'package:evolve_api/evolve_api.dart';
import 'package:flutter/foundation.dart';

class AuthContext extends ChangeNotifier {
  final String token;
  final List<Membership> memberships;

  AuthContext({required this.token, required this.memberships});
}
