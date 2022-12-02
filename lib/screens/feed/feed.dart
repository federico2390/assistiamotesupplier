import 'package:adminpanel/screens/feed/widgets/feed_list.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedList(),
    );
  }
}
