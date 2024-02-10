import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EvnService extends ChangeNotifier {
  EvnService({required this.prefs}) {
    _initiateInstance();
  }

  final SharedPreferences prefs;
  final String _baseProdURL = 'https://topparcel.com/';

  final String _urlKey = 'URL-KEY';

  String _baseURL = 'https://topparcel.com/';

  get isProdMode => _baseURL == _baseProdURL;
  get baseURL => _baseURL;

  void _initiateInstance() {
    _baseURL = prefs.getString(_urlKey) ?? _baseProdURL;
  }

  void switchEnvMode() async {
    _baseURL = _baseProdURL;
    await prefs.setString(_urlKey, _baseProdURL);
    notifyListeners();
  }
}
