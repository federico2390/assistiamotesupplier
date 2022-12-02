import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: GestureDetector(
      child: Icon(
        Icons.close,
        color: AppColors.backgroundColor,
      ),
      onTap: () => Navigator.of(context).pop(),
    ),
  );
}
