import 'package:adminpanel/providers/central.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

class Alerts {
  static get hide => StatusAlert.hide();
  static get isVisible => StatusAlert.isVisible;

  static Future successAlert(BuildContext context,
      {String? title, String? subtitle}) async {
    context.read<CentralProvider>().isLoading(true);
    Future.delayed(const Duration(seconds: 2), () {
      context.read<CentralProvider>().isLoading(false);
    });
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
    context.read<CentralProvider>().isLoading(true);
    Future.delayed(const Duration(seconds: 2), () {
      context.read<CentralProvider>().isLoading(false);
    });
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
    context.read<CentralProvider>().isLoading(true);
    Future.delayed(const Duration(seconds: 3), () {
      context.read<CentralProvider>().isLoading(false);
    });
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
