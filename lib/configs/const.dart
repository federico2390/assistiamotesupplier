import 'package:http/http.dart' as http;

class AppConst {
  /// UI
  static const double padding = 16.0;
  static const double borderRadius = 16.0;
  static const int imagePickerQuality = 70;
  static const double imagePickerHeight = 1280;
  static const double imagePickerWidth = 1280;

  /// Setting
  static const String serviceWebsite = 'https://2vcondominio.it';
  static const String servicePrivacyPolicy =
      '$serviceWebsite/privacy-policy-app';
  static const String servicePhone = '0883566469';

  /// Backend
  static const String domain = 'adminpanel.2vcondominio.it';
  static const String backendBase = 'https://$domain';
  static const String login = '$backendBase/fornitori/service/auth/login.php';
  static const String operation =
      '$backendBase/fornitori/service/misc/operation.php';
  static const String setting =
      '$backendBase/fornitori/service/misc/setting.php';
  static const String supplier =
      '$backendBase/fornitori/service/misc/supplier.php';
  static const String sender = '$backendBase/sender.php';

  /// App
  static const String appId = 'com.alessandromontrone.duevcondominiosupplier';
  static const String appName = '2V Fornitori';
  static const String appLogo = 'assets/logo.png';
  static const String clientPhone = '+14155238886';

  /// Push Notifications
  static const String firebaseChannelId = 'duev_condominio_supplier';
  static const String firebaseChannelName = 'duev_condominio_supplier';
  static const String firebaseBaseurl = 'https://fcm.googleapis.com/fcm/send';
  static const String firebaseAuthKey =
      'AAAAwWvHD9w:APA91bFc_cklqhK9KBH1CROWoa9F2GVsznTVg0iDsN4jzZPUm5KFE_SU2j8D6J3mPAusYOc7O6wXDwXRDqTWuCgDuAk7eepjwV0jWv3TezWEPGUqpDTQlR1z4rZd4PUp_vaxDL7qAZwM';

  /// HTTP Client
  var client = http.Client();
}
