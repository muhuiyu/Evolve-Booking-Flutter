import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static AuthStorage shared = AuthStorage();

  final _keyNameToken = 'token';

  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: _keyNameToken);
  }

  Future<void> saveToken(String value) async {
    await storage.write(key: _keyNameToken, value: value);
  }

  Future<void> deleteToken(String value) async {
    await storage.delete(key: _keyNameToken);
  }
}
