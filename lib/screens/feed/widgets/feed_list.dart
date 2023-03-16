import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/screens/feed/widgets/operation.dart';
import 'package:adminpanel/utils/size.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: ScreenSize.width(context),
          child: CupertinoSegmentedControl(
            selectedColor: AppColors.primaryColor,
            unselectedColor: AppColors.backgroundColor,
            borderColor: AppColors.primaryColor,
            pressedColor: AppColors.tertiaryColor,
            padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
            children: const {
              1: Text(
                'Aperti',
                style: TextStyle(fontSize: 12),
              ),
              2: Text(
                'In corso',
                style: TextStyle(fontSize: 12),
              ),
              3: Text(
                'Chiusi',
                style: TextStyle(fontSize: 12),
              ),
            },
            groupValue: context.watch<OperationProvider>().selectedSegment,
            onValueChanged: (value) {
              context.read<OperationProvider>().setSelectedSegment(value);
            },
          ),
        ),
        const Expanded(
          child: OperationSegmentedPage(),
        ),
      ],
    );
  }
}
