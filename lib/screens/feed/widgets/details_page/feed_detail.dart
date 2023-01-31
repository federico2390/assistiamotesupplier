import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedDetail extends StatefulWidget {
  const FeedDetail({super.key});

  @override
  State<FeedDetail> createState() => _FeedDetailState();
}

class _FeedDetailState extends State<FeedDetail> {
  var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final feedArguments =
        ModalRoute.of(context)!.settings.arguments as FeedArguments;

    return Scaffold(
      appBar: appBar(context),
      body: ListView(
        shrinkWrap: true,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Titolo della comunicazione',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                feedArguments.feed.notificationTitle!,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConst.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descrizione della comunicazione',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                feedArguments.feed.notificationMessage!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConst.padding),
          Divider(
            height: 1,
            color: AppColors.secondaryColor,
          ),
          const SizedBox(height: AppConst.padding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo di richiesta',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Text(
                    feedArguments.feed.notificationType!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Data di inserimento',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Text(
                    endDateTimeFormat.format(startDateTimeFormat
                        .parse(feedArguments.feed.notificationDatetime!)),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConst.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Condominio',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                ),
              ),
              FutureBuilder(
                future: context.read<UserProvider>().getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserDatabase user = snapshot.data!;
                    return Text(
                      user.palaceAddress!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: AppConst.padding * 2),
        ],
      ),
    );
  }
}
