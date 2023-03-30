import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => kIsWeb ? false : true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConst.padding),
            child: Text(
              'Questa piattaforma è disponibile solo su tablet e dispositivi mobili',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
