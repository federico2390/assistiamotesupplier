import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/screens/feed/widgets/feed_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: context.watch<CentralProvider>().loading,
      child: const Scaffold(
        body: FeedList(),
      ),
    );
  }
}
