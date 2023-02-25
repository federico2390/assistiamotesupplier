import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PalaceProvider>(builder: (context, palaceProvider, child) {
      if (palaceProvider.palaces.isNotEmpty) {
        List<TextSpan> textSpans = [];
        RegExp exp = RegExp(r'\*\*(.*?)\*\*');
        int start = 0;
        for (Match match in exp.allMatches(palaceProvider
            .palaces[palaceProvider.selectedPalace].palaceDescription!)) {
          textSpans.add(TextSpan(
              text: palaceProvider
                  .palaces[palaceProvider.selectedPalace].palaceDescription!
                  .substring(start, match.start)));
          textSpans.add(
            TextSpan(
              text: palaceProvider
                  .palaces[palaceProvider.selectedPalace].palaceDescription!
                  .substring(match.start + 2, match.end - 2),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
          start = match.end;
        }
        if (start <
            palaceProvider.palaces[palaceProvider.selectedPalace]
                .palaceDescription!.length) {
          textSpans.add(
            TextSpan(
              text: palaceProvider
                  .palaces[palaceProvider.selectedPalace].palaceDescription!
                  .substring(start),
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
            ],
          ),
        );
      } else {
        return const Loader();
      }
    });
  }
}
