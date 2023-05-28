import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/loader.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        Future.delayed(const Duration(seconds: 2), () {
          loaderProvider.setShowLabel(true);
        });

        return ListView(
          clipBehavior: Clip.none,
          children: [
            loaderProvider.showLabel == false
                ? Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Nessun elemento trovato',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class SettingLoader extends StatelessWidget {
  const SettingLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        Future.delayed(const Duration(seconds: 2), () {
          loaderProvider.settingSetShowLabel(true);
        });

        return Center(
          child: SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
