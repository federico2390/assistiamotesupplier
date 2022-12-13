import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/utils/logout_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    leading: Ink(
      child: InkWell(
        child: const Icon(Icons.settings_rounded),
        onTap: () {
          Navigator.pushNamed(context, '/setting');
        },
      ),
    ),
    title: Consumer<BottomBarProvider>(
      builder: (context, bottomBar, child) {
        return bottomBar.currentPageIndex == 0
            ? const Text('Nuovo intervento')
            : bottomBar.currentPageIndex == 1
                ? const Text('Bacheca')
                : const Text('Lettura acqua');
      },
    ),
    actions: User().isLogged == true
        ? <Widget>[
            Ink(
              padding: const EdgeInsets.only(right: AppConst.padding),
              child: InkWell(
                child: const Icon(Icons.logout_rounded),
                onTap: () {
                  buildLogoutActionSheet(context);
                },
              ),
            ),
          ]
        : null,
  );
}
