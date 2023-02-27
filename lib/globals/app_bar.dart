import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/screens/accounting/widgets/top_bar.dart';
import 'package:adminpanel/screens/change_palace/change_palace.dart';
import 'package:adminpanel/utils/loader.dart';

appBar(BuildContext context) {
  if (context.read<BottomBarProvider>().currentPageIndex == 3) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: topBar(context),
    );
  } else {
    return UserApi().isLogged == true
        ? AppBar(
            leading: context.read<BottomBarProvider>().currentPageIndex != 3
                ? Ink(
                    child: GestureDetector(
                      child: const Icon(Icons.settings_rounded),
                      onTap: () {
                        Navigator.pushNamed(context, '/setting');
                      },
                    ),
                  )
                : const SizedBox(),
            title: context.read<BottomBarProvider>().currentPageIndex == 4
                ? Text(
                    'Informazioni utili',
                    style: TextStyle(
                      color: AppColors.labelDarkColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : FutureBuilder(
                    future: context.read<PalaceProvider>().getPalaces(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.apartment_rounded, size: 20),
                              const SizedBox(width: AppConst.padding / 2),
                              Text(
                                context
                                    .watch<PalaceProvider>()
                                    .palaces[context
                                        .watch<PalaceProvider>()
                                        .selectedPalace]
                                    .palaceAddress!,
                                style: TextStyle(
                                  color: AppColors.labelDarkColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              Platform.isAndroid
                                  ? MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return const ChangePalace();
                                      },
                                    )
                                  : CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return const ChangePalace();
                                      },
                                    ),
                            );
                          },
                        );
                      } else if (snapshot.hasData) {
                        return const AppBarLoader();
                      } else {
                        return const AppBarLoader();
                      }
                    },
                  ),
            actions: [
              context.read<BottomBarProvider>().currentPageIndex != 3
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConst.padding),
                      child: Ink(
                        child: InkWell(
                          child: Icon(
                            Icons.settings_rounded,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox(),
          );
  }
}
