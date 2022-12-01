import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class Alerts {
  static successAlert(BuildContext context, {String? title, String? subtitle}) {
    return StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      title: title,
      subtitle: subtitle,
      configuration: const IconConfiguration(icon: Icons.done_rounded),
      maxWidth: 260,
    );
  }

  static errorAlert(BuildContext context, {String? title, String? subtitle}) {
    return StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      title: title,
      subtitle: subtitle,
      configuration:
          const IconConfiguration(icon: Icons.error_outline_outlined),
      maxWidth: 260,
    );
  }
}
