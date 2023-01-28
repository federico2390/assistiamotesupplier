import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class Alerts {
  static get hide => StatusAlert.hide();
  static get isVisible => StatusAlert.isVisible;

  static hideAlert() async {
    if (Alerts.isVisible == true) {
      return Alerts.hide;
    }
  }

  static Future successAlert(BuildContext context,
      {String? title, String? subtitle}) async {
    await Alerts.hideAlert();
    return StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      title: title,
      subtitle: subtitle,
      configuration: const IconConfiguration(icon: Icons.done_rounded),
      maxWidth: 260,
    );
  }

  static Future loadingAlert(BuildContext context,
      {String? title, String? subtitle}) async {
    await Alerts.hideAlert();
    return StatusAlert.show(
      context,
      duration: const Duration(seconds: 30),
      title: title,
      subtitle: subtitle,
      configuration: const IconConfiguration(icon: Icons.update_rounded),
      maxWidth: 260,
    );
  }

  static Future errorAlert(BuildContext context,
      {String? title, String? subtitle}) async {
    await Alerts.hideAlert();
    return StatusAlert.show(
      context,
      duration: const Duration(seconds: 3),
      title: title,
      subtitle: subtitle,
      configuration: const IconConfiguration(icon: Icons.error_outline_rounded),
      maxWidth: 260,
    );
  }
}
