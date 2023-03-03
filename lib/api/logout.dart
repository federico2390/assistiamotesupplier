import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';

class LogoutApi {
  Future logout(BuildContext context) async {
    final user = await context.read<UserProvider>().getLocalUser();
    if (user.userId != null) {
      try {
        await Alerts.errorAlert(context,
            title: 'Un momento...', subtitle: 'Esco dall\'account');
        await FirebaseMessaging.instance
            .unsubscribeFromTopic(AppConst.firebaseTopic);
        context.read<OperationProvider>().removeAllImage();
        context.read<ReadingProvider>().removeAllImage();

        logged = null;

        int? rememberData = SharedPrefs.getInt('rememberData');
        if (rememberData == 0 || rememberData == null) {
          await SharedPrefs.instance.clear();
          await context.read<UserProvider>().deleteLocalUser();
        } else {
          await context.read<UserProvider>().updateLocalUser(
                UserDatabase(
                  userId: '',
                  userEmail: '',
                  userName: '',
                  userCf: '',
                  userUsername: user.userUsername!,
                  userPassword: user.userPassword!,
                  userToken: '',
                  notification: '',
                  firstTimeLogged: '',
                ),
              );
          await SharedPrefs.instance.remove('logged');
        }

        await Future.delayed(const Duration(seconds: 2), () async {
          Navigator.pop(context);
          await Alerts.hideAlert();
          await Navigator.pushNamedAndRemoveUntil(
              context, '/login', (Route<dynamic> route) => false);
        });
      } catch (error) {
        print('ERROR_logout: ${error.toString()}');
      }
    } else {
      print('ERROR User not found');

      await Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Per favore riprova');
    }
  }
}
