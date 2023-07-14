import 'package:flutter/material.dart';

import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/const.dart';

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
          title: const Text(
            'Richieste',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppConst.padding),
              child: Ink(
                child: GestureDetector(
                  child: const Icon(Icons.notifications),
                  onTap: () {
                    Navigator.pushNamed(context, '/notification');
                  },
                ),
              ),
            ),
          ],
        )
      : const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox(),
        );
}
