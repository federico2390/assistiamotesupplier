import 'package:http/http.dart' as http;

class AppConst {
  /// UI
  static const double padding = 16.0;
  static const double borderRadius = 16.0;
  static const int imagePickerQuality = 70;
  static const double imagePickerHeight = 1280;
  static const double imagePickerWidth = 1280;

  /// Setting
  static const String serviceWebsite = 'https://assistiamote.it';
  static const String servicePrivacyPolicy = '$serviceWebsite/privacy-policy';

  /// Backend
  static const String domain = 'adminpanel-assistiamote.it';
  static const String backendBase = 'https://$domain';
  static const String login = '$backendBase/operatore/service/auth/login.php';
  static const String operation =
      '$backendBase/operatore/service/misc/operation.php';
  static const String setting =
      '$backendBase/operatore/service/misc/setting.php';
  static const String supplier =
      '$backendBase/operatore/service/misc/supplier.php';
  static const String notification =
      '$backendBase/operatore/service/misc/notification.php';
  static const String sign = '$backendBase/operatore/service/misc/sign.php';

  /// App
  static const String appId = 'com.assistiamote.app';
  static const String appName = 'Assistiamo Te';
  static const String appLogo = 'assets/logo.png';
  static const String clientPhone = '+390804038868';

  /// Push Notifications
  static const String firebaseChannelId = 'assistiamo_te_supplier';
  static const String firebaseChannelName = 'assistiamo_te_supplier';
  static const String firebaseBaseurl = 'https://fcm.googleapis.com/fcm/send';
  static const String firebaseAuthKey =
      'AAAAWbet338:APA91bHzNrK_GLkAWrahFpnoUQdxO3NSWi7MfJKBvW9wgj15W9rjKN9LmnUEPjUKN1ScukVMI2YJ4zXDmfgjNHxQk9A5MFu0hLl0Ap0QfiMdsjzqH_LpJchDEcljVhm0w04_YL-gx6Vj';

  /// HTTP Client
  var client = http.Client();
}
