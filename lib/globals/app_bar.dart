import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar appBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    title: Consumer<BottomBarProvider>(
      builder: (context, bottomBar, child) {
        return bottomBar.currentPageIndex == 0
            ? const Text('Richiedi intervento')
            : bottomBar.currentPageIndex == 1
                ? const Text('Avvisi pubblicati')
                : const Text('Lettura acqua');
      },
    ),
  );
}
