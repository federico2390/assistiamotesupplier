import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/screens/accounting/accounting_page.dart';
import 'package:adminpanel/screens/feed/feed_page.dart';
import 'package:adminpanel/screens/info/info_page.dart';
import 'package:adminpanel/screens/operation/operation_page.dart';
import 'package:adminpanel/screens/reading/reading_page.dart';

body(BuildContext context) {
  return context.read<BottomBarProvider>().currentPageIndex == 0
      ? const FeedPage()
      : context.read<BottomBarProvider>().currentPageIndex == 1
          ? const OperationPage()
          : context.read<BottomBarProvider>().currentPageIndex == 2
              ? const ReadingPage()
              : context.read<BottomBarProvider>().currentPageIndex == 3
                  ? const AccountingPage()
                  : const InfoPage();
}
