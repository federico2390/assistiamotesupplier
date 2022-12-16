import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/screens/accounting/widgets/top_bar.dart';
import 'package:adminpanel/utils/logout_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

appBar(BuildContext context) {
  return context.read<BottomBarProvider>().currentPageIndex == 3
      ? PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: topBar(context),
        )
      : AppBar(
          leading: context.read<BottomBarProvider>().currentPageIndex != 3
              ? Ink(
                  child: InkWell(
                    child: const Icon(Icons.settings_rounded),
                    onTap: () {
                      Navigator.pushNamed(context, '/setting');
                    },
                  ),
                )
              : const SizedBox(),
          title: Consumer<BottomBarProvider>(
            builder: (context, bottomBar, child) {
              return bottomBar.currentPageIndex == 0
                  ? const Text('Nuovo intervento')
                  : bottomBar.currentPageIndex == 1
                      ? const Text('Bacheca')
                      : bottomBar.currentPageIndex == 2
                          ? const Text('Lettura acqua')
                          : const SizedBox();
            },
          ),
          actions: User().isLogged == true &&
                  context.read<BottomBarProvider>().currentPageIndex != 3
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
