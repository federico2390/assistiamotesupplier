import 'package:http/http.dart' as http;

class AppConst {
  /// UI
  static const double padding = 16.0;
  static const double borderRadius = 16.0;
  static const int imagePickerQuality = 70;
  static const double imagePickerHeight = 1280;
  static const double imagePickerWidth = 1280;

  /// Setting
  static const String serviceWebsite = 'https://surianogestionicondominiali.it';
  static const String servicePrivacyPolicy =
      '$serviceWebsite/privacy-policy-app';
  static const String servicePhone = '0883566469';

  /// Backend
  static const String domain = 'adminpanel.surianogestionicondominiali.it';
  static const String backendBase = 'https://$domain';
  static const String login = '$backendBase/fornitori/service/auth/login.php';
  static const String operation =
      '$backendBase/fornitori/service/misc/operation.php';
  static const String setting =
      '$backendBase/fornitori/service/misc/setting.php';
  static const String supplier =
      '$backendBase/fornitori/service/misc/supplier.php';

  /// App
  static const String appId = 'com.alessandromontrone.studiosurianosupplier';
  static const String appName = 'Suriano Fornitori';
  static const String appLogo = 'assets/logo.png';

  /// Push Notifications
  static const String firebaseChannelId = 'studio_suriano_fornitori';
  static const String firebaseChannelName = 'studio_suriano_fornitori';
  static const String firebaseBaseurl = 'https://fcm.googleapis.com/fcm/send';
  static const String firebaseAuthKey =
      'AAAAMufPjuA:APA91bFbjwpMKqeYoILYs4saRo7ytPDpjc1WU2aBn47tauQgdqLSReJa4Ib3oo5tu03qKvCvNt2SMR0GrSo_fdRvDycGt7zbMIg_RvGTu0CbslSlcjSYwHdJMnh6-6e3bF63ZS7Zf8RO';

  /// HTTP Client
  var client = http.Client();
}
