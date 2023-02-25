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
    // 'Rate Personali': '$serviceBase/Rate/SituazionePersonale',
    // 'Rate Inquilini': '$serviceBase/Rate/SituazioneInquilini',
  };

  /// Setting
  static const String serviceHostPrivacyPolicy =
      'https://www.cedhousesuite.com/privacy-policy';
  static const String serviceWebsite = 'https://studiopedico.it';
  static const String servicePrivacyPolicy =
      '$serviceWebsite/privacy-policy-app';

  /// Backend
  static const String backendBase = 'https://adminpanel.buuumit.com';
  static const String login = '$backendBase/user/service/auth/login.php';
  static const String operation =
      '$backendBase/user/service/misc/operation.php';
  static const String user = '$backendBase/user/service/misc/user.php';
  static const String feed = '$backendBase/user/service/misc/feed.php';
  static const String reading = '$backendBase/user/service/misc/reading.php';
  static const String palace = '$backendBase/user/service/misc/palace.php';
  static const String supplier = '$backendBase/user/service/misc/supplier.php';
  static const String setting = '$backendBase/user/service/misc/setting.php';
  static const String operationMediaFolder = '$backendBase/user/media/';
  static const String readingMediaFolder = '$backendBase/user/media/';

  /// App
  static const String appId = 'it.federicodesalvatore.adminpanel';
  static const String appName = 'Studio PA';
  static const String appLogo = 'assets/logo.png';

  /// Push Notifications
  static const String firebaseChannelId = 'studio_pa';
  static const String firebaseChannelName = 'studio_pa';
  static const String firebaseTopic = 'allusers';
}
