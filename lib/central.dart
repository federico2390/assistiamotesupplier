import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/screens/feed.dart';
import 'package:adminpanel/screens/operation.dart';
import 'package:adminpanel/screens/reading.dart';
import 'package:adminpanel/globals/app_bar.dart';
import 'package:adminpanel/globals/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Central extends StatefulWidget {
  const Central({super.key});

  @override
  State<Central> createState() => _CentralState();
}

class _CentralState extends State<Central> {
  @override
  Widget build(BuildContext context) {
    StatefulWidget body() {
      return context.read<BottomBarProvider>().currentPageIndex == 0
          ? const Operation()
          : context.read<BottomBarProvider>().currentPageIndex == 1
              ? const Feed()
              : const Reading();
    }

    return Scaffold(
      appBar: appBar(),
      body: body(),
      bottomNavigationBar: bottomnBar(context),
    );
  }
}
