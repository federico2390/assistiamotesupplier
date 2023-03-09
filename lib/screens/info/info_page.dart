// ignore_for_file: unnecessary_null_comparison

import 'package:adminpanel/utils/launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PalaceProvider>(
      builder: (context, palaceProvider, child) {
        palaceProvider.getPalaces(context);

        if (palaceProvider.palaces != null &&
            palaceProvider
                    .palaces[palaceProvider.selectedPalace].palaceDescription !=
                null) {
          var palaceDescription = palaceProvider
              .palaces[palaceProvider.selectedPalace].palaceDescription!;

          List<TextSpan> textSpans = [];
          RegExp exp = RegExp(r'\*\*(.*?)\*\*');
          int start = 0;
          for (Match match in exp.allMatches(palaceDescription)) {
            textSpans.add(TextSpan(
                text: palaceDescription.substring(start, match.start)));
            textSpans.add(
              TextSpan(
                text:
                    palaceDescription.substring(match.start + 2, match.end - 2),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
            start = match.end;
          }
          if (start < palaceDescription.length) {
            textSpans.add(
              TextSpan(
                text: palaceDescription.substring(start),
              ),
            );
          }

          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.all(AppConst.padding),
              children: [
                RichText(
                  text: TextSpan(
                    children: textSpans,
                    style: TextStyle(
                      color: AppColors.labelDarkColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                palaceProvider.palaces[palaceProvider.selectedPalace]
                            .palaceUtilsName!.isNotEmpty &&
                        palaceProvider.palaces[palaceProvider.selectedPalace]
                            .palaceUtilsNumber!.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(height: AppConst.padding),
                          Divider(
                            height: 1,
                            color: AppColors.secondaryColor,
                          ),
                          const SizedBox(height: AppConst.padding),
                          const Text(
                            'Numeri utili',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppConst.padding),
                          ListView.separated(
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: AppConst.padding),
                            itemCount: palaceProvider
                                .palaces[palaceProvider.selectedPalace]
                                .palaceUtilsName!
                                .replaceAll('  ', '\n')
                                .split('\n')
                                .length,
                            itemBuilder: (context, index) {
                              String name = palaceProvider
                                  .palaces[palaceProvider.selectedPalace]
                                  .palaceUtilsName!
                                  .replaceAll('  ', '\n')
                                  .split('\n')
                                  .toList()[index];

                              String number = palaceProvider
                                  .palaces[palaceProvider.selectedPalace]
                                  .palaceUtilsNumber!
                                  .replaceAll('  ', '\n')
                                  .split('\n')
                                  .toList()[index];

                              return TapDebouncer(
                                onTap: () async {
                                  await launchUrls('tel:$number');
                                },
                                builder: (BuildContext context,
                                    TapDebouncerFunc? onTap) {
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    elevation: 7,
                                    shadowColor: AppColors.secondaryColor
                                        .withOpacity(.15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppConst.borderRadius),
                                    ),
                                    color: AppColors.backgroundColor,
                                    child: ListTile(
                                      title: Text(
                                        name,
                                        style: TextStyle(
                                          color: AppColors.labelDarkColor,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.phone_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                      onTap: onTap,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: AppConst.padding * 2),
              ],
            ),
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
