class AppConst {
  /// UI
  static const double padding = 16.0;
  static const double borderRadius = 16.0;

  /// Service
  static const String serviceBase = 'https://studiopa.cedhousesuite.it';
  static const Map<String, String> accountingItems = {
    'Fatture': '$serviceBase/Contabilita/Fatture',
    'Consuntivo': '$serviceBase/Contabilita/ComparazionePreventivoConsuntivo',
    'Rate Personali': '$serviceBase/Rate/SituazionePersonale',
    'Rate Inquilini': '$serviceBase/Rate/SituazioneInquilini',
  };

  /// Backend
  static const String backendBase = 'https://adminpanel.buuumit.com';
  static const String login = '$backendBase/service/auth/login.php';
  static const String logout = '$backendBase/service/auth/logout.php';
  static const String operation = '$backendBase/service/misc/operation.php';
  static const String feed = '$backendBase/service/misc/feed.php';
  static const String reading = '$backendBase/service/misc/reading.php';
  static const String notification = '$backendBase/service/misc/notification.php';

  /// App
  static const String appId = 'it.federicodesalvatore.adminpanel';
  static const String appName = 'Studio PA';
}
