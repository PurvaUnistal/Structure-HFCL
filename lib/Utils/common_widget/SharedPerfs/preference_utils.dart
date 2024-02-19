import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static SharedPreferences? prefs;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<dynamic> getString({required String key}) async {
    if (prefs!.getString(key) != null) {
      return prefs!.getString(key);
    } else {
      return "";
    }
  }

  static Future<void> setString(
      {required String key, required String value}) async {
    await prefs?.setString(key, value);
  }

  static Future<void> removeAll({required String key}) async {
    await prefs?.remove(key);
  }

  static Future<void> clearAll() async {
    await prefs?.clear();
  }
}
