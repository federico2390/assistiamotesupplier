import 'package:adminpanel/screens/feed/widgets/feed_list.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedList(),
    );
  }
}
