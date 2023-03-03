import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';

class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          key: GlobalKey(),
          initialUrlRequest: URLRequest(
            url: Uri.parse(AppConst.serviceBase),
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              javaScriptCanOpenWindowsAutomatically: true,
              preferredContentMode: UserPreferredContentMode.DESKTOP,
              horizontalScrollBarEnabled: false,
              verticalScrollBarEnabled: false,
              // clearCache: true,
            ),
            android: AndroidInAppWebViewOptions(
              geolocationEnabled: false,
              initialScale: -1,
            ),
            ios: IOSInAppWebViewOptions(
              enableViewportScale: true,
              automaticallyAdjustsScrollIndicatorInsets: true,
            ),
          ),
          onWebViewCreated: (controller) async {
            context.read<AccountingProvider>().currentController(controller);
            await Alerts.loadingAlert(
              context,
              title: 'Caricamento',
              subtitle: 'Non cambiare sezione',
            );
          },
          onLoadStop: (InAppWebViewController controller, Uri? url) async {
            final user = await context.read<UserProvider>().getLocalUser();
            await controller.getUrl().then((value) async {
              if (value!.path.contains("/Utente/Autenticazione") == true) {
                await controller.evaluateJavascript(source: '''
                document.getElementsByTagName("body")[0].style.display = "none";
                document.getElementById('studiopa-header-container').style.display = "none";
                document.getElementById('HomeSlider').style.display = "none";
                document.getElementById('Username').value = '${user.userUsername!}';
                document.getElementById('Password').value = '${user.userPassword!}';
                document.getElementById('loginForm').submit();
                ''');
              } else if (value == Uri.parse('${AppConst.serviceBase}/')) {
                await controller.evaluateJavascript(source: '''
                document.getElementsByTagName("body")[0].style.display = "none";
                ''');
              } else {
                await controller.evaluateJavascript(source: '''
                document.getElementById('studiopa-header-container').style.display = "none";
                document.getElementById('HomeSlider').style.display = "none";
                ''');
              }
            });

            await Alerts.hideAlert();
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) async {
            await Alerts.loadingAlert(
              context,
              title: 'Caricamento',
              subtitle: 'Non cambiare sezione',
            );
          },
        ),
      ],
    );
  }
}
