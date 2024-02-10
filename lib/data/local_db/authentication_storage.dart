import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final FlutterSecureStorage prefs;

  AuthStorage({
    required this.prefs,
  });

  static const String _isAuthorizedKey = 'authorization';

  Future<bool> setAuthorization(bool isAuthorized) async {
    try {
      await prefs.write(key: _isAuthorizedKey, value: isAuthorized.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isAuthorized() async {
    final value = await prefs.read(key: _isAuthorizedKey);
    return value != null ? value == 'true' : false;
  }

  Future<bool> logout() async {
    try {
      await prefs.delete(key: _isAuthorizedKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
