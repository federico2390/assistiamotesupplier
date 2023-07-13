import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = const Color(0xFFFFFFFF);
  static Color primaryColor = const Color(0xFFD21E4B);
  static Color secondaryColor = const Color(0xFF9E9E9E);
  static Color tertiaryColor = const Color(0x2D6FC104);
  static Color labelLightColor = const Color(0xFFFFFFFF);
  static Color labelDarkColor = const Color(0xFF000000);
  static Color successColor = const Color(0xFF248A3D);
  static Color errorColor = const Color(0xFF880404);
  static Color attentionColor = const Color(0xFFE28401);
  static Color transparentColor = const Color(0x00000000);
  static Color focusedColor = const Color(0xFF000000);

  static Map<int, Color> materialPrimaryColor = {
    50: const Color.fromRGBO(210, 30, 75, .1),
    100: const Color.fromRGBO(210, 30, 75, .2),
    200: const Color.fromRGBO(210, 30, 75, .3),
    300: const Color.fromRGBO(210, 30, 75, .4),
    400: const Color.fromRGBO(210, 30, 75, .5),
    500: const Color.fromRGBO(210, 30, 75, .6),
    600: const Color.fromRGBO(210, 30, 75, .7),
    700: const Color.fromRGBO(210, 30, 75, .8),
    800: const Color.fromRGBO(210, 30, 75, .9),
    900: const Color.fromRGBO(210, 30, 75, 1),
  };
}
