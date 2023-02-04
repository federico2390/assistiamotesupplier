import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/globals/app_bar/utils/utils.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

MenuButton palaceDropdownButton(BuildContext context, UserDatabase user) {
  return MenuButton<String>(
    itemBackgroundColor: AppColors.backgroundColor,
    menuButtonBackgroundColor: AppColors.backgroundColor,
    topDivider: false,
    popupHeight: ScreenSize.height(context) / 2,
    scrollPhysics: const AlwaysScrollableScrollPhysics(),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
        border: Border.all(width: 0, color: AppColors.transparentColor)),
    items: changePalaceFilterButton,
    divider: Divider(color: AppColors.secondaryColor, height: 0),
    itemBuilder: (String value) {
      return Container(
        height: 44,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
        decoration: const BoxDecoration(
            // color:
            //     context.read<NotificationProvider>().selectedFeedButton == value
            //         ? AppColors.tertiaryColor
            //         : AppColors.backgroundColor,
            ),
        child: Text(value),
      );
    },
    onItemSelected: (String value) {
      // context.read<NotificationProvider>().setSelectedFeedButton(value);
      // context.read<SearchProvider>().clearSearchBar();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.apartment_rounded, size: 20),
        const SizedBox(width: AppConst.padding / 2),
        Text(
          user.palaceAddress!,
          style: TextStyle(
            color: AppColors.labelDarkColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: AppConst.padding / 6),
        Icon(Icons.arrow_drop_down, color: AppColors.labelDarkColor),
      ],
    ),
  );
}
