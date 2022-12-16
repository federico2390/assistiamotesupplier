import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Login {
  Future login(BuildContext context, String username, String password) async {
    try {
      Alerts.loadingAlert(
        context,
        title: 'Un momento...',
        subtitle: 'Effettuo l\'accesso',
      );

      var response = await http.post(
        Uri.parse(AppConst.login),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'username': username.trim(),
          'password': password.trim(),
        },
      );

      if (response.statusCode == 200) {
        Alerts.hide;

        final jsonData = json.decode(response.body);
        final UserDatabase user = UserDatabase.fromJson(jsonData[0]);

        context.read<UserProvider>().addUser(
              UserDatabase(
                userId: user.userId!.trim(),
                palaceId: user.palaceId!.trim(),
                palaceName: user.palaceName!.trim(),
                palaceCf: user.palaceCf!.trim(),
                palaceAddress: user.palaceAddress!.trim(),
                userEmail: user.userEmail!.trim(),
                userName: user.userName!.trim(),
                userSurname: user.userSurname!.trim(),
                userCf: user.userCf!.trim(),
                userUsername: user.userUsername!.trim(),
                userPassword: user.userPassword!.trim(),
                userToken: user.userToken!.trim(),
              ),
            );

        await SharedPrefs.setInt('logged', 1);

        Alerts.successAlert(context,
                title: 'Accesso riuscito!',
                subtitle: 'Benvenuta/o ${user.userName}')
            .whenComplete(() {
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
        });
      }
    } on PlatformException catch (error) {
      print('PlatformException_login: $error');
    } catch (error) {
      print('ERROR_login: $error');
    }
  }
}
