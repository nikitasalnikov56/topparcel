import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage prefs;

  TokenStorage({
    required this.prefs,
  }) {
    _loadToken();
  }

  get token => _token;
  String? _token;
  static const String _tokenKey = 'new_arctica_token_key';

  Future<bool> setToken(String token) async {
    try {
      _token = token;
      await prefs.write(key: _tokenKey, value: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _loadToken() async {
    _token = await prefs.read(key: _tokenKey);
  }

  /// i don't know why getter doesn't work
  Future<String> loadToken() async {
    return await prefs.read(key: _tokenKey) ?? '';
  }

  ///

  Future<bool> clearToken() async {
    try {
      _token = '';
      await prefs.delete(key: _tokenKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
