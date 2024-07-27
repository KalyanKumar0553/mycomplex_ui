import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _bearerTokenKey = "bearer_token";

  static Future<void> saveBearerToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bearerTokenKey, token);
  }

  static Future<String?> getBearerToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bearerTokenKey);
  }

  static Future<void> removeBearerToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bearerTokenKey);
  }
}
