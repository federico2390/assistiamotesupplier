import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:adminpanel/api/feed.dart';
import 'package:adminpanel/models/feed.dart';

class FeedProvider extends ChangeNotifier {
  List<Feed> _feeds = [];
  List<Feed> get feeds => _feeds;
  Future<List<Feed>> getFeeds(BuildContext context) async {
    try {
      List<Feed> feedList = await FeedApi().getFeeds(context);

      for (int i = 0; i < feedList.length; i++) {
        if (feedList[i].notificationExpiration!.isNotEmpty &&
            DateFormat('dd/MM/yyyy HH:mm:ss')
                .parse(feedList[i].notificationExpiration!)
                .isBefore(DateTime.now())) {
          feedList.remove(feedList[i]);
        }
      }

      feedList.sort(
        (a, b) => DateTime.parse(
          DateFormat('dd/MM/yyyy HH:mm:ss')
              .parse(b.notificationDatetime!)
              .toIso8601String(),
        ).compareTo(
          DateTime.parse(
            DateFormat('dd/MM/yyyy HH:mm:ss')
                .parse(a.notificationDatetime!)
                .toIso8601String(),
          ),
        ),
      );

      feedList.sort((a, b) =>
          (a.notificationOpened == 'false' ? 0 : 1) -
          (b.notificationOpened == 'false' ? 0 : 1));

      _feeds = feedList;
    } catch (error) {
      print(error);
    }

    notifyListeners();
    return _feeds;
  }

  void cancelFeeds() {
    _feeds.clear();
    notifyListeners();
  }

  int _selectedSegment = 1;
  int get selectedSegment => _selectedSegment;

  void setSelectedSegment(int index) {
    _selectedSegment = index;
    notifyListeners();
  }
}
