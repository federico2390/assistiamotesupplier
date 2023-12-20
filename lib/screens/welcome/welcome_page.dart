import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/notification_manager.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async => kIsWeb ? false : true,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              const Spacer(),
              Center(
                child: Image.asset(
                  AppConst.appLogo,
                  fit: BoxFit.contain,
                  width: kIsWeb ? 150 : ScreenSize.width(context) / 1.5,
                ),
              ),
              const Spacer(),
              Text(
                'Benvenuta/o\n${context.read<UserProvider>().localuser.supplierName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.labelDarkColor,
                ),
              ),
              !kIsWeb ? const Spacer() : const SizedBox(),
              !kIsWeb
                  ? Consumer<SettingProvider>(
                      builder: (context, settingProvider, child) {
                        return FutureBuilder(
                          future: Future.wait([
                            NotificationManager.requestPermisison(context),
                            settingProvider.getNotificationSetting(context),
                          ]),
                          builder: (context, snapshot) {
                            return SettingsList(
                              shrinkWrap: true,
                              contentPadding: EdgeInsets.zero,
                              lightTheme: SettingsThemeData(
                                settingsListBackground:
                                    AppColors.backgroundColor,
                              ),
                              brightness: Brightness.light,
                              applicationType: kIsWeb
                                  ? ApplicationType.both
                                  : Platform.isAndroid
                                      ? ApplicationType.material
                                      : ApplicationType.cupertino,
                              sections: [
                                SettingsSection(
                                  tiles: <SettingsTile>[
                                    SettingsTile.switchTile(
                                      onToggle: (value) {
                                        settingProvider.updateNotification(
                                            context, value);
                                      },
                                      initialValue: settingProvider
                                                  .notificationSetting
                                                  .notification ==
                                              'true'
                                          ? true
                                          : false,
                                      leading: const Icon(
                                          Icons.notifications_rounded),
                                      title: const Text('Comunicazioni'),
                                      description: const Text(
                                          'Quando abilitato, riceverai notifiche direttamente sul tuo dispositivo ogni volta che ci saranno nuove comunicazioni.'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  : const SizedBox(),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: AppConst.padding, right: AppConst.padding, bottom: 45),
          child: TapDebouncer(
            onTap: () async {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
            },
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return Button(
                text: 'Iniziamo',
                onPressed: onTap,
              );
            },
          ),
        ),
      ),
    );
  }
}
