import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppConst.padding),
          children: [
            SizedBox(height: ScreenSize.height(context) / 3),
            Center(
              child: Image.asset(
                AppConst.appLogo,
                fit: BoxFit.contain,
                height: ScreenSize.width(context) / 3,
              ),
            ),
            const SizedBox(height: AppConst.padding * 2),
            Text(
              'Benvenuta/o\n${context.read<UserProvider>().user.userName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.labelDarkColor,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            left: AppConst.padding, right: AppConst.padding, bottom: 45),
        child: Button(
          text: 'Iniziamo',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }
}
