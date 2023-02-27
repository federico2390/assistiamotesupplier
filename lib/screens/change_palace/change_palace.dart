import 'package:adminpanel/providers/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/screens/change_palace/widgets/app_bar.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/size.dart';

class ChangePalace extends StatelessWidget {
  const ChangePalace({super.key});

  @override
  Widget build(BuildContext context) {
    int? idx;

    return Consumer4<LoaderProvider, FeedProvider, OperationProvider,
        PalaceProvider>(
      builder: (context, loaderProvider, feedProvider, operationProvider,
          palaceProvider, child) {
        return AbsorbPointer(
          absorbing: loaderProvider.isSaving,
          child: Scaffold(
            appBar: appBar(context),
            body: StatefulBuilder(
              builder: (context, setState) {
                return FutureBuilder(
                  future: palaceProvider.getPalaces(context),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        clipBehavior: Clip.none,
                        padding: const EdgeInsets.symmetric(horizontal: 12.5),
                        itemCount: palaceProvider.palaces.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: AppConst.padding),
                        itemBuilder: (context, index) {
                          Palace palace = palaceProvider.palaces[index];

                          return Card(
                            elevation: 7,
                            shadowColor:
                                AppColors.secondaryColor.withOpacity(.15),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppConst.borderRadius),
                            ),
                            color: AppColors.backgroundColor,
                            child: CheckboxListTile(
                              value: idx != null
                                  ? idx == index
                                  : palaceProvider.selectedPalace == index,
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
                                setState(() {
                                  idx = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: TapDebouncer(
              cooldown: const Duration(seconds: 3),
              onTap: () async {
                if (idx != palaceProvider.selectedPalace) {
                  loaderProvider.setIsSaving(true);

                  feedProvider.cancelFeeds();
                  operationProvider.cancelOperations();
                  palaceProvider.setSelectedPalace(idx!);

                  await Alerts.loadingAlert(
                    context,
                    title: 'Un momento...',
                    subtitle: 'Cambio condominio',
                  );

                  Future.delayed(const Duration(seconds: 3), () async {
                    loaderProvider.setIsSaving(false);
                    await Alerts.hideAlert();
                    Navigator.of(context).pop();
                  });
                } else {
                  await Alerts.errorAlert(context,
                      title: 'Ops!', subtitle: 'Condominio già selezionato');
                }
              },
              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return Button(
                  text: 'Salva',
                  width: ScreenSize.width(context) - AppConst.padding * 2,
                  onPressed: onTap,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
