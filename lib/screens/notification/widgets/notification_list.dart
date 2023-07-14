import 'package:adminpanel/models/notifications.dart';
import 'package:adminpanel/screens/notification/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/notification.dart';
import 'package:adminpanel/utils/loader.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.notifications.isNotEmpty) {
            return SizedBox(
              height: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppConst.padding - 5,
                  AppConst.padding / 2,
                  AppConst.padding - 5,
                  AppConst.padding * 2,
                ),
                itemCount: notificationProvider.notifications.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: AppConst.padding / 2),
                itemBuilder: (context, index) {
                  Notifications notification =
                      notificationProvider.notifications[index];

                  return TapDebouncer(
                    onTap: () async {},
                    builder: (BuildContext context, TapDebouncerFunc? onTap) {
                      return Card(
                        elevation: 7,
                        shadowColor: kIsWeb
                            ? AppColors.secondaryColor.withOpacity(.5)
                            : AppColors.secondaryColor.withOpacity(.15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppConst.borderRadius),
                        ),
                        color: AppColors.primaryColor,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppConst.padding,
                              vertical: AppConst.padding / 2),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.message_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                          minLeadingWidth: 0,
                          title: Text(
                            notification.notificationTitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.labelDarkColor,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppConst.padding / 4),
                              ReadMoreText(
                                notification.notificationMessage!,
                                trimLines: 2,
                                colorClickableText: AppColors.secondaryColor,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '  altro',
                                trimExpandedText: '   meno',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                moreStyle: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                lessStyle: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          onTap: onTap,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
