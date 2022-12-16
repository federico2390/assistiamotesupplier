import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/screens/accounting/widgets/bottom_bar.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class AccountingPage extends StatefulWidget {
  const AccountingPage({super.key});

  @override
  State<AccountingPage> createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as AccountingArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(arguments.url),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptCanOpenWindowsAutomatically: true,
                preferredContentMode: UserPreferredContentMode.DESKTOP,
                horizontalScrollBarEnabled: false,
                verticalScrollBarEnabled: false,
                clearCache: true,
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
              Alerts.loadingAlert(
                context,
                title: 'Un momento...',
                subtitle: 'Stiamo recuperando i dati del tuo condominio.',
              );
            },
            onLoadStop: (InAppWebViewController controller, Uri? url) {
              controller.evaluateJavascript(source: '''
                if (window.location.href.includes("ReturnUrl")) {
                  window.location.assign("${arguments.url}");
                }

                document.getElementById('studiopa-header-container').style.display = "none";
                document.getElementById('HomeSlider').style.display = "none";
                document.getElementById('Username').value = "VNM29P";
                document.getElementById('Password').value = "95173479";
                document.getElementById('loginForm').submit();
                ''');

              Alerts.hide;
            },
          ),
        ],
      ),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
