import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrls(String link) async {
  Uri url = Uri.parse(link);

  canLaunchUrl(url).then((bool result) async {
    if (result == true) {
      if (!await launchUrl(url)) {
        print('Non posso aprire il link: $url');
      }
    }
  });
}
