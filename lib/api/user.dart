import 'package:adminpanel/utils/shared_preference.dart';

class User {
  bool get isLogged => SharedPrefs.getInt('logged') != null ? true : false;
}
