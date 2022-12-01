import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      padding: EdgeInsets.all(AppConst.padding),
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: AppConst.padding),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            elevation: 7,
            shadowColor: AppColors.secondaryColor.withOpacity(.15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            child: const ListTile(
              title: Text('Titolo di esempio'),
              subtitle: Text('Sottotitolo di esempio'),
            ),
          ),
          onTap: () {},
        );
      },
    ));
  }
}
