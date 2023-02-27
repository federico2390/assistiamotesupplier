import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      child: Icon(
        Icons.close_rounded,
        color: AppColors.labelDarkColor,
      ),
      onTap: () => Navigator.of(context).pop(),
    ),
    title: const Text('Cambia condominio'),
  );
}
