import 'package:shared_preferences/shared_preferences.dart';

class AccountStorage {
  final SharedPreferences prefs;

  const AccountStorage({
    required this.prefs,
  });
}
