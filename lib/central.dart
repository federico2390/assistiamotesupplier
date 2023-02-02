import 'package:adminpanel/globals/body.dart';

import 'package:adminpanel/globals/app_bar.dart';
import 'package:adminpanel/globals/bottom_bar.dart';
import 'package:flutter/material.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
