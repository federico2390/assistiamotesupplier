import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/screens/change_palace/widgets/app_bar.dart';

class ChangePalace extends StatelessWidget {
  const ChangePalace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder(
        future: context.read<PalaceProvider>().getPalaces(context),
        builder: (context, snapshot) {
          return SizedBox(
            height: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 12.5),
              itemCount: context.read<PalaceProvider>().palaces.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: AppConst.padding),
              itemBuilder: (context, index) {
                Palace palace = context.read<PalaceProvider>().palaces[index];

                return Card(
                  elevation: 7,
                  shadowColor: AppColors.secondaryColor.withOpacity(.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConst.borderRadius),
                  ),
                  color: AppColors.backgroundColor,
                  child: CheckboxListTile(
                    value:
                        context.watch<PalaceProvider>().selectedPalace == index,
                    activeColor: AppColors.primaryColor,
                    title: Text(
                      palace.palaceAddress!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.labelDarkColor,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<PalaceProvider>().setSelectedPalace(index);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Button(
        text: 'Salva',
        width: ScreenSize.width(context) - AppConst.padding * 2,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
