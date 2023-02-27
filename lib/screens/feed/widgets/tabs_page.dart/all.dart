import 'package:adminpanel/api/feed.dart';
import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/feed.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class AllSegmentedPage extends StatelessWidget {
  const AllSegmentedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(
        AppConst.padding - 5,
        AppConst.padding,
        AppConst.padding - 5,
        AppConst.padding * 2,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              const Text(
                'Comunicazioni',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  child: const Text(
                    'Mostra tutti',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    context.read<FeedProvider>().setSelectedSegment(2);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConst.padding / 1.5),
        Consumer<FeedProvider>(
          builder: (context, feedProvider, child) {
            if (feedProvider.feeds.isNotEmpty) {
              List<Feed> feeds = feedProvider.feeds;
              return ListView.separated(
                shrinkWrap: true,
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feeds.length >= 2 ? 2 : feeds.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: AppConst.padding / 2),
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
                          shadowColor:
                              AppColors.secondaryColor.withOpacity(.15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        feed.notificationMessage!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color:
                                              feed.notificationOpened == 'false'
                                                  ? AppColors.labelLightColor
                                                  : AppColors.secondaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        endDateTimeFormat.format(
                                            startDateTimeFormat.parse(
                                                feed.notificationExpiration!)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color:
                                              feed.notificationOpened == 'false'
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
        ),
        const SizedBox(height: AppConst.padding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              const Text(
                'Interventi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  child: const Text(
                    'Mostra tutti',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onTap: () {
                    context.read<FeedProvider>().setSelectedSegment(3);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConst.padding / 1.5),
        Consumer<OperationProvider>(
          builder: (context, operationProvider, child) {
            if (operationProvider.operations.isNotEmpty) {
              List<Operation> operations = operationProvider.operations;
              return ListView.separated(
                shrinkWrap: true,
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: operations.length >= 3 ? 3 : operations.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: AppConst.padding / 2),
                itemBuilder: (context, index) {
                  Operation operation = operations[index];

                  String labelState = '';
                  if (operation.operationLastUpdate!.isNotEmpty) {
                    if (operation.operationState == 'false') {
                      labelState = 'Aggiornato';
                    } else {
                      labelState = 'Chiuso';
                    }
                  } else if (operation.operationLastUpdate!.isEmpty) {
                    if (operation.operationState == 'false') {
                      labelState = 'Aperto';
                    } else {
                      labelState = 'Chiuso';
                    }
                  }

                  return TapDebouncer(
                    onTap: () async {
                      await OperationApi()
                          .markOperationAsOpened(operation)
                          .whenComplete(() {
                        Navigator.pushNamed(
                          context,
                          '/operation_detail',
                          arguments: OperationArguments(
                            operation,
                          ),
                        );
                      });
                    },
                    builder: (BuildContext context, TapDebouncerFunc? onTap) {
                      return GestureDetector(
                        onTap: onTap,
                        child: Card(
                          elevation: 7,
                          shadowColor:
                              AppColors.secondaryColor.withOpacity(.15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppConst.borderRadius),
                          ),
                          color: operation.operationOpened == 'false'
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.build_rounded,
                                  color: operation.operationOpened == 'false'
                                      ? AppColors.labelLightColor
                                      : AppColors.primaryColor,
                                ),
                              ],
                            ),
                            minLeadingWidth: 0,
                            title: Row(
                              children: [
                                Text(
                                  operation.operation!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: operation.operationOpened == 'false'
                                        ? AppColors.labelLightColor
                                        : AppColors.labelDarkColor,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  alignment: Alignment.topRight,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConst.padding / 1.5,
                                    vertical: AppConst.padding / 7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConst.padding / 3),
                                    color: operation.operationOpened == 'false'
                                        ? AppColors.labelLightColor
                                        : AppColors.primaryColor,
                                  ),
                                  child: Text(
                                    labelState,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          operation.operationOpened == 'false'
                                              ? AppColors.primaryColor
                                              : AppColors.backgroundColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Text(
                              operation.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: operation.operationOpened == 'false'
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
        ),
      ],
    );
  }
}
