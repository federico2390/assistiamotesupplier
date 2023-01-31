import 'package:adminpanel/utils/shared_preference.dart';

class UserApi {
  bool get isLogged => SharedPrefs.getInt('logged') != null ? true : false;
}
