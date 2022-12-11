import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/secure_storage.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  bool get isLogged => SharedPrefs.getInt('logged') != null ? true : false;

  Future login(BuildContext context, String username, String password) async {
    try {
      Alerts.loadingAlert(
        context,
        title: 'Un momento...',
        subtitle: 'Effettuo l\'accesso',
      );

      var response = await http.post(
        Uri.parse(AppConst.base + AppConst.login),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        Alerts.hide;

        final jsonData = json.decode(response.body);
        final User user = User.fromJson(jsonData[0]);

        await SharedPrefs.setString('user_id', user.userId!);
        await SharedPrefs.setString('palace_id', user.palaceId!);
        await SharedPrefs.setString('palace_name', user.palaceName!);
        await SharedPrefs.setString('palace_cf', user.palacaceCf!);
        await SharedPrefs.setString('palace_address', user.palaceAddress!);
        await SharedPrefs.setString('user_email', user.userEmail!);
        await SharedPrefs.setString('user_name', user.userName!);
        await SharedPrefs.setString('user_surname', user.userSurname!);
        await SharedPrefs.setString('user_cf', user.userCf!);
        await SecureStorage.write('user_username', user.userUsername!);
        await SecureStorage.write('user_password', user.userPassword!);
        await SharedPrefs.setString('user_token', user.userToken!);
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

  Future<bool> logout(BuildContext context, String userId) async {
    try {
      Alerts.errorAlert(context,
          title: 'Un momento...', subtitle: 'Esco dall\'account');

      var response = await http.post(
        Uri.parse(AppConst.base + AppConst.logout),
        body: {"id": userId},
      );
      if (response.body == 'Success') {
        Alerts.hide;
        return true;
      }
    } catch (error) {
      print('ERROR_logout: ${error.toString()}');
    }
    return false;
  }
}
