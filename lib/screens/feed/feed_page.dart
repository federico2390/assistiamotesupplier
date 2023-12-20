import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/screens/feed/widgets/feed_list.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async => kIsWeb ? false : true,
      child: const FeedList(),
    );
  }
}
