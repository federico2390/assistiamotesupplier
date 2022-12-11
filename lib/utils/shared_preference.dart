import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static bool? getBool(String key) => instance.getBool(key);
  static Future<bool> setBool(String key, bool value) =>
      instance.setBool(key, value);

  static String? getString(String key) => instance.getString(key);
  static Future<bool> setString(String key, String value) =>
      instance.setString(key, value);

  static int? getInt(String key) => instance.getInt(key);
  static Future<bool> setInt(String key, int value) =>
      instance.setInt(key, value);

  static List<String>? getStringList(String key) => instance.getStringList(key);
  static Future<bool> setStringList(String key, List<String> value) =>
      instance.setStringList(key, value);
}
