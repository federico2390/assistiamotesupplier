import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      child: Icon(
        Icons.close_rounded,
        color: AppColors.backgroundColor,
      ),
      onTap: () => Navigator.of(context).pop(),
    ),
  );
}
