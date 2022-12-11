import 'package:adminpanel/configs/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<String> read(String key) async {
    String value = "";
    try {
      value = await storage.read(
            key: key,
            iOptions: iOSOptions(),
            aOptions: androidOptions(),
          ) ??
          "";
    } catch (e) {
      print(e);
    }
    return value;
  }

  static Future<void> write(String key, String value) async {
    try {
      await storage.write(
        key: key,
        value: value,
        iOptions: iOSOptions(),
        aOptions: androidOptions(),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> delete(String key) async {
    try {
      await storage.delete(
        key: key,
        iOptions: iOSOptions(),
        aOptions: androidOptions(),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, String>> readAll() async {
    var map = <String, String>{};
    try {
      map = await storage.readAll(
        iOptions: iOSOptions(),
        aOptions: androidOptions(),
      );
    } catch (e) {
      print(e);
    }
    return map;
  }

  static Future<void> deleteAll() async {
    try {
      await storage.deleteAll(
        iOptions: iOSOptions(),
        aOptions: androidOptions(),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> containsKey(String key) async {
    bool value = false;
    try {
      value = await storage.containsKey(
        key: key,
        iOptions: iOSOptions(),
        aOptions: androidOptions(),
      );
    } catch (e) {
      print(e);
    }
    return value;
  }

  static IOSOptions iOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  static AndroidOptions androidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: AppConst.appId,
      );
}
