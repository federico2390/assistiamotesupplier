import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutApi {
  Future logout(BuildContext context) async {
    final user = await context.read<UserProvider>().getUser();
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
          await context.read<UserProvider>().deleteUser();
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
                  notification: '',
                  firstTimeLogged: '',
                ),
              );
          await SharedPrefs.instance.remove('logged');
        }

        Navigator.pop(
          context,
          await Navigator.pushNamedAndRemoveUntil(
              context, '/login', (Route<dynamic> route) => false),
        );
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
