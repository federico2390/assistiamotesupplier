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
  static const String firebaseChannelId = 'studio_suriano';
  static const String firebaseChannelName = 'studio_suriano';
  static const String firebaseBaseurl = 'https://fcm.googleapis.com/fcm/send';
  static const String firebaseAuthKey =
      'AAAACJBFyYI:APA91bGKiTsazg3d2YIYRrF4Q2Fvmgf1aYZme_Msluq_Bwb2odZbB6kBvD_LktEAELoUiGP_eSAW4xnQI6MCc6gRr4OBOdnR4zSgatDSGr5T4yOas61hea_HkSfk0l6SuXEi3mwHdWSK';
}
