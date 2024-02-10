import 'package:shared_preferences/shared_preferences.dart';

class EmailStorage {
  final SharedPreferences prefs;

  EmailStorage({
    required this.prefs,
  }) {
    _loadEmail();
  }

  get email => _email;
  String? _email;
  static const String _emailKey = 'new_arctica_email';

  Future<bool> setEmail(String email) async {
    _email = email;
    bool emailSet = await prefs.setString(_emailKey, email);
    return emailSet;
  }

  void _loadEmail() async {
    _email = prefs.getString(_emailKey);
  }

  Future<bool> clearEmail() async {
    _email = '';
    bool removeEmail = await prefs.remove(_emailKey);

    return removeEmail;
  }
}
