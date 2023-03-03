import 'package:flutter/material.dart';

import 'package:adminpanel/configs/colors.dart';

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
