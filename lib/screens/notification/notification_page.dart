import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/screens/notification/widgets/notification_list.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => kIsWeb ? false : true,
      child: const NotificationList(),
    );
  }
}
