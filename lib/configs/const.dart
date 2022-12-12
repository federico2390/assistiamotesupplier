class AppConst {
  static const double padding = 16.0;
  static const double borderRadius = 16.0;

  static const Map<String, String> accountingItems = {
    'Fatture': 'https://studiopa.cedhousesuite.it/Contabilita/Fatture',
    'Consuntivo':
        'https://studiopa.cedhousesuite.it/Contabilita/ComparazionePreventivoConsuntivo',
    'Rate Personali':
        'https://studiopa.cedhousesuite.it/Rate/SituazionePersonale',
    'Rate Inquilini':
        'https://studiopa.cedhousesuite.it/Rate/SituazioneInquilini',
  };

  static const String base = 'https://adminpanel.buuumit.com';
  static const String login = '/service/auth/login.php';
  static const String logout = '/service/auth/logout.php';
  static const String postOperation = '/service/misc/postOperation.php';
  static const String getFeed = '/service/misc/getFeed.php';
  static const String postReading = '/service/misc/postReading.php';

  static const String appId = 'it.federicodesalvatore.adminpanel';
}
