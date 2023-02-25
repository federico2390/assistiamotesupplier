import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/feed.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FeedApi {
  Future<List<Feed>> getFeeds(BuildContext context) async {
    List<Feed> feed = [];
    try {
      final user = context.read<UserProvider>().localuser;
      Palace palace = context
          .read<PalaceProvider>()
          .palaces[context.read<PalaceProvider>().selectedPalace];

      var response = await http.post(
        Uri.parse(AppConst.feed),
        body: {
          "get_notification": 'get_notification',
          'user_id': user.userId,
          'palace_id': palace.palaceId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        feed = feedFromJson(response.body);
      } else {
        print('Can\'t get Feed');
      }
    } catch (error) {
      print('ERROR_getFeed: $error');
    }
    return feed;
  }

  Future markNotificationAsOpened(Feed feed) async {
    try {
      var response = await http.post(
        Uri.parse(AppConst.feed),
        body: {
          'mark_as_opened': 'mark_as_opened',
          'feed_id': feed.notificationId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        print('Can\'t mark as opened Notification');
      }
    } catch (error) {
      print('ERROR_markNotificationAsOpened: $error');
    }
  }
}
