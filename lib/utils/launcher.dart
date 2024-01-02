import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrls(String link) async {
  Uri url = Uri.parse(link);

  canLaunchUrl(url).then((bool result) async {
    if (result == true) {
      if (!await launchUrl(url)) {
        debugPrint('Non posso aprire il link: $url');
      }
    }
  });
}

launchMap(String address) async {
  String link = address.replaceAll(' ', '+');
  if (Platform.isIOS) {
    link = "maps://http://maps.apple.com/?q=$address";
  } else if (Platform.isAndroid) {
    link = "http://maps.google.com/?q=$address";
  }
  if (await canLaunchUrl(Uri.parse(link))) {
    await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Non posso aprire il link: $link');
  }
}
