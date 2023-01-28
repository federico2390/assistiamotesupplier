import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/notification/notification.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/screens/setting/widgets/app_bar.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:adminpanel/utils/privacy_policy_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  @override
  Widget build(BuildContext context) {
    context.read<SettingProvider>().getNotification();

    return Scaffold(
      appBar: appBar(context),
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: EdgeInsetsDirectional.zero,
            title: const Text('Generali'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  context.read<SettingProvider>().updateNotification(
                      context, NotificationDatabase(notification: value));
                },
                initialValue:
                    context.watch<SettingProvider>().notification.notification,
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Ricevi notifiche'),
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.zero,
            title: const Text('Legale'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.lock_outline_rounded),
                title: const Text('Informativa privacy'),
                onPressed: (context) {
                  buildPrivacyPolicyActionSheet(context);
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.web_rounded),
                title: const Text('Sito web'),
                onPressed: (context) {
                  launchUrls(AppConst.serviceWebsite);
                },
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.zero,
            tiles: <SettingsTile>[
              SettingsTile(
                enabled: false,
                title: FutureBuilder(
                  future: getAppVersion(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Text(
                        'Versione ${snapshot.data!}',
                        style: TextStyle(color: AppColors.secondaryColor),
                      );
                    }
                    return Text(
                      '',
                      style: TextStyle(color: AppColors.secondaryColor),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
