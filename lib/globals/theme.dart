import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:adminpanel/configs/colors.dart';

class AppTheme {
  static ThemeData theme() {
    MaterialColor primaryColor =
        MaterialColor(0xFFD21E4B, AppColors.materialPrimaryColor);

    return ThemeData(
      primarySwatch: primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      splashColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.labelDarkColor,
        titleTextStyle: TextStyle(
          color: AppColors.labelDarkColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        unselectedItemColor: AppColors.secondaryColor,
        selectedItemColor: AppColors.primaryColor,
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}
