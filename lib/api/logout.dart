import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Logout {
  Future<bool> logout(BuildContext context) async {
    final user = await context.read<UserProvider>().getUser();
    if (user.userId != null) {
      try {
        Alerts.errorAlert(context,
            title: 'Un momento...', subtitle: 'Esco dall\'account');

        logged = null;

        int? rememberData = SharedPrefs.getInt('rememberData');
        if (rememberData == 0 || rememberData == null) {
          SharedPrefs.instance.clear();
          context.read<UserProvider>().deleteUser();
          context.read<SettingProvider>().deleteNotification();
        } else {
          context.read<UserProvider>().updateUser(
                UserDatabase(
                  userId: '',
                  palaceId: '',
                  palaceName: '',
                  palaceCf: '',
                  palaceAddress: '',
                  userEmail: '',
                  userName: '',
                  userCf: '',
                  userUsername: user.userUsername!,
                  userPassword: user.userPassword!,
                  userToken: '',
                ),
              );

          SharedPrefs.instance.remove('logged');
        }

        Future.delayed(const Duration(seconds: 3), () {
          context.read<CentralProvider>().isLoading(false);
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (Route<dynamic> route) => false);
        });
      } catch (error) {
        print('ERROR_logout: ${error.toString()}');
      }
      return false;
    } else {
      Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Per favore contatta l\'amministratore.');
      return false;
    }
  }
}
