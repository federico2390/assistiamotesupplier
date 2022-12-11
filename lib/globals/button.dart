import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.color,
    this.text,
    this.icon,
    this.onPressed,
  });

  final Color? color;
  final String? text;
  final Icon? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            style: TextButton.styleFrom(
              backgroundColor: color ?? AppColors.primaryColor,
            ),
            onPressed: onPressed,
            child: icon ??
                Text(
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
            color: color ?? AppColors.primaryColor,
            onPressed: onPressed,
            padding: icon != null ? EdgeInsets.zero : null,
            child: icon ??
                Text(
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
