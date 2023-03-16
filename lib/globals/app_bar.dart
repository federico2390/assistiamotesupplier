import 'package:flutter/material.dart';

import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/colors.dart';

appBar(BuildContext context) {
  return UserApi().isLogged == true
      ? AppBar(
          leading: Ink(
            child: GestureDetector(
              child: const Icon(Icons.settings_rounded),
              onTap: () {
                Navigator.pushNamed(context, '/setting');
              },
            ),
          ),
          title: Text(
            'Interventi',
            style: TextStyle(
              color: AppColors.labelDarkColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            SizedBox(),
          ],
        )
      : const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox(),
        );
}
