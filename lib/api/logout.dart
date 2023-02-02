import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutApi {
  Future<bool> logout(BuildContext context) async {
    final user = await context.read<UserProvider>().getUser();
    if (user.userId != null) {
      try {
        await Alerts.errorAlert(context,
            title: 'Un momento...', subtitle: 'Esco dall\'account');

        logged = null;

        int? rememberData = SharedPrefs.getInt('rememberData');
        if (rememberData == 0 || rememberData == null) {
          await SharedPrefs.instance.clear();
          await context.read<UserProvider>().deleteUser();
          await context.read<SettingProvider>().deleteNotification();
        } else {
          await context.read<UserProvider>().updateUser(
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
        }

        await SharedPrefs.instance.remove('logged');
        await SettingApi.notificationSwitch(context, false);
        await FirebaseMessaging.instance
            .unsubscribeFromTopic(AppConst.firebaseTopic);

        await Future.delayed(const Duration(seconds: 3), () async {
          Navigator.pop(context);
          await Navigator.pushNamedAndRemoveUntil(
              context, '/login', (Route<dynamic> route) => false);
        });
      } catch (error) {
        print('ERROR_logout: ${error.toString()}');
      }
      return false;
    } else {
      await Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Per favore contatta l\'amministratore.');
      return false;
    }
  }
}
