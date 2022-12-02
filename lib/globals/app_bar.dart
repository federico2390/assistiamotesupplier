import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    title: Consumer<BottomBarProvider>(
      builder: (context, bottomBar, child) {
        return bottomBar.currentPageIndex == 0
            ? const Text('Nuovo intervento')
            : bottomBar.currentPageIndex == 1
                ? const Text('Bacheca')
                : bottomBar.currentPageIndex == 2
                    ? const Text('Lettura acqua')
                    : const Text('Contabilità');
      },
    ),
  );
}
