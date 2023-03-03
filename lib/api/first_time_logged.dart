import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:adminpanel/configs/const.dart';

class FirstTimeLogged {
  Future firstTimeLogged(BuildContext context, String userId) async {
    try {
      await http.post(
        Uri.parse(AppConst.login),
        body: {"user_id": userId},
      );
    } catch (error) {
      print('ERROR_firstTimeLogged: ${error.toString()}');
    }
  }
}
