import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: onPressed,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.labelLightColor,
                fontSize: 15,
              ),
            ),
          )
        : CupertinoButton(
            color: AppColors.primaryColor,
            onPressed: onPressed,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.labelLightColor,
                fontSize: 15,
              ),
            ),
          );
  }
}
