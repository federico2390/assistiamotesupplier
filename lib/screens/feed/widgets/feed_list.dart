import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/screens/feed/widgets/tabs_page.dart/all.dart';
import 'package:adminpanel/screens/feed/widgets/tabs_page.dart/comunication.dart';
import 'package:adminpanel/screens/feed/widgets/tabs_page.dart/operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedList extends StatelessWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<FeedProvider>().selectedSegment == 1
        ? const AllSegmentedPage()
        : context.watch<FeedProvider>().selectedSegment == 2
            ? const ComunicationSegmentedPage()
            : const OperationSegmentedPage();
  }
}
