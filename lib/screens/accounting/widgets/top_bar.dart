import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

Column topBar(BuildContext context) {
  return Column(
    children: [
      const Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: AppConst.padding / 2),
          for (var i = 0; i < AppConst.accountingItems.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: 40,
                  width: ScreenSize.width(context) /
                      AppConst.accountingItems.length,
                  child: Button(
                    accounting: true,
                    text: AppConst.accountingItems.keys.toList()[i],
                    color: context.watch<AccountingProvider>().selected == i
                        ? AppColors.primaryColor
                        : AppColors.secondaryColor,
                    onPressed: () {
                      context.read<AccountingProvider>().selectedPage(i);
                      context
                          .read<AccountingProvider>()
                          .inAppWebViewController!
                          .loadUrl(
                            urlRequest: URLRequest(
                              url: Uri.parse(
                                AppConst.accountingItems.values.toList()[i],
                              ),
                            ),
                          );
                    },
                  ),
                ),
              ),
            ),
          const SizedBox(width: AppConst.padding / 2),
        ],
      )
    ],
  );
}
