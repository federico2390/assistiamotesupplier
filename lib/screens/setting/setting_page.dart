import 'dart:io';

import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/screens/setting/widgets/app_bar.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:adminpanel/utils/logout_action_sheet.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => kIsWeb ? false : true,
      child: Scaffold(
        appBar: appBar(context),
        body: Consumer<SettingProvider>(
          builder: (context, settingProvider, child) {
            if (UserApi().isLogged == true) {
              return StreamBuilder(
                stream: settingProvider.getSetting(context).asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.notification!.isNotEmpty) {
                    return SettingsList(
                      contentPadding: kIsWeb
                          ? const EdgeInsets.all(AppConst.padding)
                          : null,
                      lightTheme: kIsWeb
                          ? SettingsThemeData(
                              settingsListBackground: AppColors.backgroundColor,
                            )
                          : Platform.isAndroid
                              ? SettingsThemeData(
                                  settingsListBackground:
                                      AppColors.backgroundColor,
                                )
                              : null,
                      brightness: Brightness.light,
                      applicationType: kIsWeb
                          ? ApplicationType.both
                          : Platform.isAndroid
                              ? ApplicationType.material
                              : ApplicationType.cupertino,
                      sections: [
                        !kIsWeb
                            ? SettingsSection(
                                tiles: <SettingsTile>[
                                  SettingsTile.switchTile(
                                    onToggle: (value) {
                                      settingProvider.updateNotification(
                                          context, value);
                                    },
                                    initialValue:
                                        settingProvider.setting.notification ==
                                                'true'
                                            ? true
                                            : false,
                                    leading:
                                        const Icon(Icons.notifications_rounded),
                                    title: const Text('Comunicazioni'),
                                    description: const Text(
                                        'Quando abilitato, riceverai notifiche direttamente sul tuo dispositivo ogni volta che ci saranno nuove comunicazioni.'),
                                  ),
                                ],
                              )
                            : const SettingsSection(
                                tiles: [],
                              ),
                        SettingsSection(
                          tiles: <SettingsTile>[
                            SettingsTile.navigation(
                              leading: const Icon(Icons.lock_rounded),
                              title: const Text('Informativa privacy'),
                              onPressed: (context) {
                                launchUrls(AppConst.servicePrivacyPolicy);
                              },
                            ),
                            SettingsTile.navigation(
                              leading: const Icon(Icons.web_rounded),
                              title: const Text('Sito web'),
                              description: const Text(
                                  'In questa sezione puoi trovare tutte le informazioni riguardanti la raccolta, l\'uso e la protezione dei tuoi dati personali. Per maggiori informazioni clicca sito web.'),
                              onPressed: (context) {
                                launchUrls(AppConst.serviceWebsite);
                              },
                            ),
                          ],
                        ),
                        SettingsSection(
                          tiles: <SettingsTile>[
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
                              title: Text(
                                'Utente',
                                style:
                                    TextStyle(color: AppColors.secondaryColor),
                              ),
                              description: kIsWeb
                                  ? Text(
                                      context
                                              .read<UserProvider>()
                                              .localuser
                                              .supplierName!
                                              .isNotEmpty
                                          ? context
                                              .read<UserProvider>()
                                              .localuser
                                              .supplierName!
                                          : '',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    )
                                  : null,
                              trailing: !kIsWeb
                                  ? Text(
                                      context
                                              .read<UserProvider>()
                                              .localuser
                                              .supplierName!
                                              .isNotEmpty
                                          ? context
                                              .read<UserProvider>()
                                              .localuser
                                              .supplierName!
                                          : '',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 16,
                                      ),
                                    )
                                  : null,
                            ),
                            SettingsTile(
                              enabled: false,
                              title: FutureBuilder(
                                future: getAppVersion(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    return Text(
                                      'Versione ${snapshot.data!}',
                                      style: TextStyle(
                                          color: AppColors.secondaryColor),
                                    );
                                  }
                                  return Text(
                                    '',
                                    style: TextStyle(
                                        color: AppColors.secondaryColor),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SettingLoader();
                  }
                },
              );
            } else {
              return const SettingLoader();
            }
          },
        ),
      ),
    );
  }
}
