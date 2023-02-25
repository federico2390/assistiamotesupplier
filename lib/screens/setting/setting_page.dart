import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/screens/setting/widgets/app_bar.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:adminpanel/utils/logout_action_sheet.dart';
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
    return Scaffold(
      appBar: appBar(context),
      body: Consumer<SettingProvider>(
        builder: (context, settingProvider, child) {
          return FutureBuilder(
            future: settingProvider.getSetting(context),
            builder: (context, snapshot) {
              return SettingsList(
                lightTheme: Platform.isAndroid
                    ? SettingsThemeData(
                        settingsListBackground: AppColors.backgroundColor,
                      )
                    : null,
                brightness: Brightness.light,
                applicationType: Platform.isAndroid
                    ? ApplicationType.material
                    : ApplicationType.cupertino,
                sections: [
                  SettingsSection(
                    tiles: <SettingsTile>[
                      SettingsTile.switchTile(
                        onToggle: (value) {
                          settingProvider.updateNotification(context, value);
                        },
                        initialValue:
                            settingProvider.setting.notification == 'true'
                                ? true
                                : false,
                        leading: const Icon(Icons.notifications_outlined),
                        title: const Text('Comunicazioni'),
                        description: const Text(
                            'Abilitalo se vuoi ricevere tutte le comunicazioni che riguardano te e il tuo condominio.'),
                      ),
                    ],
                  ),
                  SettingsSection(
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
                    tiles: <SettingsTile>[
                      SettingsTile.navigation(
                        leading: const Icon(Icons.change_circle_outlined),
                        title: const Text('Cambia condominio'),
                        onPressed: (context) {
                          Navigator.pushNamed(context, '/change_palace');
                        },
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.logout_rounded),
                        title: const Text('Esci'),
                        onPressed: (context) {
                          buildLogoutActionSheet(context);
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    tiles: <SettingsTile>[
                      SettingsTile(
                        enabled: false,
                        title: FutureBuilder(
                          future: getAppVersion(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return Text(
                                'Versione ${snapshot.data!}',
                                style:
                                    TextStyle(color: AppColors.secondaryColor),
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
              );
            },
          );
        },
      ),
    );
  }
}
