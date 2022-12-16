import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

ListView topBar(BuildContext context) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: AppConst.accountingItems.length,
    separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(width: 8),
    padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
    itemBuilder: (context, index) {
      return Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 40,
            width: ScreenSize.width(context) / 4 - 14,
            child: Button(
              accounting: true,
              text: AppConst.accountingItems.keys.toList()[index],
              onPressed: () {
                context
                    .read<AccountingProvider>()
                    .inAppWebViewController!
                    .loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(
                          AppConst.accountingItems.values.toList()[index],
                        ),
                      ),
                    );
              },
            ),
          ),
        ],
      );
    },
  );
}
