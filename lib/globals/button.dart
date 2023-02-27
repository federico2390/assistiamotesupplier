import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.color,
    this.text = '',
    this.icon,
    this.width,
    this.onPressed,
    this.accounting = false,
  });

  final Color? color;
  final String? text;
  final Icon? icon;
  final double? width;
  final void Function()? onPressed;
  final bool? accounting;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: width,
      child: Platform.isAndroid
          ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: color ?? AppColors.primaryColor,
                padding: icon != null
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: onPressed,
              child: icon ??
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.labelLightColor,
                      fontSize: accounting == true ? 12 : 15,
                    ),
                  ),
            )
          : CupertinoButton(
              color: color ?? AppColors.primaryColor,
              onPressed: onPressed,
              padding: icon != null
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(horizontal: 8),
              child: icon ??
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: accounting == true ? null : FontWeight.bold,
                      color: AppColors.labelLightColor,
                      fontSize: 15,
                    ),
                  ),
            ),
    );
  }
}
