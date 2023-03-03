import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:adminpanel/utils/size.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        Future.delayed(const Duration(seconds: 2), () {
          loaderProvider.setShowLabel(true);
        });

        return loaderProvider.showLabel == false
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
              );
      },
    );
  }
}

class AppBarLoader extends StatelessWidget {
  const AppBarLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 3,
        width: ScreenSize.width(context) / 5,
        child: LinearProgressIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.tertiaryColor,
        ),
      ),
    );
  }
}
