import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    MaterialColor primaryColor =
        MaterialColor(0xFF880404, AppColors.materialPrimaryColor);

    return ThemeData(
      primarySwatch: primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      splashColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      appBarTheme: AppBarTheme(
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
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
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
