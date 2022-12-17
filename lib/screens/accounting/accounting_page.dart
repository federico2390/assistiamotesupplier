import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class AccountingPage extends StatefulWidget {
  const AccountingPage({super.key});

  @override
  State<AccountingPage> createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> {
  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: context.watch<CentralProvider>().loading,
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              key: key,
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
              onWebViewCreated: (controller) {
                context
                    .read<AccountingProvider>()
                    .currentController(controller);
                Alerts.loadingAlert(
                  context,
                  title: 'Un momento...',
                  subtitle: 'Stiamo recuperando i dati del tuo condominio.',
                );
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                final user = await context.read<UserProvider>().getUser();
                await controller.getUrl().then((value) {
                  print(value);

                  if (value!.path.contains("/Utente/Autenticazione") == true) {
                    controller.evaluateJavascript(source: '''
                  document.getElementsByTagName("body")[0].style.display = "none";
                  document.getElementById('studiopa-header-container').style.display = "none";
                  document.getElementById('HomeSlider').style.display = "none";
                  document.getElementById('Username').value = '${user.userUsername!}';
                  document.getElementById('Password').value = '${user.userPassword!}';
                  document.getElementById('loginForm').submit();
                  ''');
                  } else if (value == Uri.parse('${AppConst.serviceBase}/')) {
                    controller.evaluateJavascript(source: '''
                  document.getElementsByTagName("body")[0].style.display = "none";
                  ''');
                  } else {
                    controller.evaluateJavascript(source: '''
                  document.getElementById('studiopa-header-container').style.display = "none";
                  document.getElementById('HomeSlider').style.display = "none";
                  ''');
                  }
                });

                Alerts.hide;
                context.read<CentralProvider>().isLoading(false);
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                Alerts.loadingAlert(
                  context,
                  title: 'Un momento...',
                  subtitle: 'Stiamo recuperando i dati del tuo condominio.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
