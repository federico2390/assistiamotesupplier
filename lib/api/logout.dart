import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Logout {
  Future<bool> logout(BuildContext context, String userId) async {
    try {
      Alerts.errorAlert(context,
          title: 'Un momento...', subtitle: 'Esco dall\'account');

      var response = await http.post(
        Uri.parse(AppConst.logout),
        body: {"user_id": userId},
      );
      if (response.body == 'Success') {
        return true;
      }
    } catch (error) {
      print('ERROR_logout: ${error.toString()}');
    }
    return false;
  }
}
