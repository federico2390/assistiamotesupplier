import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor =
      const Color(0xFFFFFFFF); // const Color(0xFFF2F2F4);
  static Color primaryColor = const Color(0xFF880404);
  static Color secondaryColor = const Color(0xFF9E9E9E);
  static Color tertiaryColor = const Color(0x31990000);
  static Color labelLightColor = const Color(0xFFFFFFFF);
  static Color labelDarkColor = const Color(0xFF000000);
  static Color errorColor = const Color(0xFF880404);
  static Color transparentColor = const Color(0x00000000);
  static Color focusedColor = const Color(0xFF000000);

  static Map<int, Color> materialPrimaryColor = {
    50: const Color.fromRGBO(136, 4, 4, .1),
    100: const Color.fromRGBO(136, 4, 4, .2),
    200: const Color.fromRGBO(136, 4, 4, .3),
    300: const Color.fromRGBO(136, 4, 4, .4),
    400: const Color.fromRGBO(136, 4, 4, .5),
    500: const Color.fromRGBO(136, 4, 4, .6),
    600: const Color.fromRGBO(136, 4, 4, .7),
    700: const Color.fromRGBO(136, 4, 4, .8),
    800: const Color.fromRGBO(136, 4, 4, .9),
    900: const Color.fromRGBO(136, 4, 4, 1),
  };
}
