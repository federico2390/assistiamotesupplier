import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/capitalize_first_letter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

loadUser(BuildContext context, TextEditingController palaceController,
    TextEditingController tenantController) async {
  if (User().isLogged == true) {
    final user = await context.read<UserProvider>().getUser();
    palaceController.text = user.palaceName != null ? user.palaceName! : '';

    String userName = user.userName != null
        ? '${user.userName!.capitalizeFirstLetter()!} '
        : '';
    String userSurname = user.userSurname != null
        ? user.userSurname!.capitalizeFirstLetter()!
        : '';
    tenantController.text = userName + userSurname;
  }
}
