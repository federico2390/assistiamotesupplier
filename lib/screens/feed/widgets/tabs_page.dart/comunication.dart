import 'package:adminpanel/api/feed.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/feed.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ComunicationSegmentedPage extends StatelessWidget {
  const ComunicationSegmentedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Consumer<FeedProvider>(
      builder: (context, feedProvider, child) {
        if (feedProvider.feeds.isNotEmpty) {
          List<Feed> feeds = feedProvider.feeds;
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              AppConst.padding - 5,
              AppConst.padding,
              AppConst.padding - 5,
              AppConst.padding * 2,
            ),
            itemCount: feeds.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppConst.padding),
            itemBuilder: (context, index) {
              Feed feed = feeds[index];

              return TapDebouncer(
                onTap: () async {
                  await FeedApi()
                      .markNotificationAsOpened(feed)
                      .whenComplete(() {
                    Navigator.pushNamed(
                      context,
                      '/feed_detail',
                      arguments: FeedArguments(
                        feed,
                      ),
                    );
                  });
                },
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  return GestureDetector(
                    onTap: onTap,
                    child: Card(
                      elevation: 7,
                      shadowColor: AppColors.secondaryColor.withOpacity(.15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppConst.borderRadius),
                      ),
                      color: feed.notificationOpened == 'false'
                          ? AppColors.primaryColor
                          : AppColors.backgroundColor,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mail_outline_rounded,
                              color: feed.notificationOpened == 'false'
                                  ? AppColors.labelLightColor
                                  : AppColors.primaryColor,
                            ),
                          ],
                        ),
                        minLeadingWidth: 0,
                        isThreeLine: feed.notificationExpiration!.isNotEmpty
                            ? true
                            : false,
                        title: Text(
                          feed.notificationTitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: feed.notificationOpened == 'false'
                                ? AppColors.labelLightColor
                                : AppColors.labelDarkColor,
                          ),
                        ),
                        subtitle: feed.notificationExpiration!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feed.notificationMessage!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: feed.notificationOpened == 'false'
                                          ? AppColors.labelLightColor
                                          : AppColors.secondaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    endDateTimeFormat.format(startDateTimeFormat
                                        .parse(feed.notificationExpiration!)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: feed.notificationOpened == 'false'
                                          ? AppColors.labelLightColor
                                          : AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                feed.notificationMessage!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: feed.notificationOpened == 'false'
                                      ? AppColors.labelLightColor
                                      : AppColors.secondaryColor,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
