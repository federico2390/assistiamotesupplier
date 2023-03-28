class AppConst {
  /// UI
  static const double padding = 16.0;
  static const double borderRadius = 16.0;
  static const int imagePickerQuality = 70;
  static const double imagePickerHeight = 1280;
  static const double imagePickerWidth = 1280;

  /// Service
  static const String serviceBase = 'https://studiopa.cedhousesuite.it';
  static const Map<String, String> accountingItems = {
    'Fatture': '$serviceBase/Contabilita/Fatture',
    'Consuntivo': '$serviceBase/Contabilita/ComparazionePreventivoConsuntivo',
  };

  /// Setting
  static const String serviceHostPrivacyPolicy =
      'https://www.cedhousesuite.com/privacy-policy';
  static const String serviceWebsite = 'https://studiopedico.it';
  static const String servicePrivacyPolicy =
      '$serviceWebsite/privacy-policy-app';
  static const String servicePhone = '0883513748';

  /// Backend
  static const String domain = 'adminpanel.studiopedico.it/fornitori';
  static const String backendDomain = 'adminpanel.studiopedico.it';

  static const String backendBase = 'https://$domain';
  static const String login = '$backendBase/user/service/auth/login.php';
  static const String loginBackend =
      '$backendBase/admin/service/auth/login.php';
  static const String operation =
      '$backendBase/user/service/misc/operation.php';
  static const String notification =
      '$backendBase/admin/service/misc/notification.php';
  static const String operationBackend =
      '$backendBase/admin/service/misc/operation.php';
  static const String user = '$backendBase/user/service/misc/user.php';
  static const String userBackend = '$backendBase/admin/service/misc/user.php';
  static const String setting = '$backendBase/user/service/misc/setting.php';
  static const String settingBackend =
      '$backendBase/admin/service/misc/setting.php';

  /// App
  static const String appId = 'com.alessandromontrone.studiopasupplier';
  static const String appName = 'PA Fornitori';
  static const String appLogo = 'assets/logo.png';

  /// Push Notifications
  static const String firebaseChannelId = 'studio_pa_fornitori';
  static const String firebaseChannelName = 'studio_pa_fornitori';
  static const String firebaseBaseurl = 'https://fcm.googleapis.com/fcm/send';
  static const String firebaseAuthKey =
      'AAAACJBFyYI:APA91bGKiTsazg3d2YIYRrF4Q2Fvmgf1aYZme_Msluq_Bwb2odZbB6kBvD_LktEAELoUiGP_eSAW4xnQI6MCc6gRr4OBOdnR4zSgatDSGr5T4yOas61hea_HkSfk0l6SuXEi3mwHdWSK';
}
