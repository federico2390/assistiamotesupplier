import 'dart:io';

import 'package:adminpanel/globals/theme.dart';
import 'package:adminpanel/database/notification/notification.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/search.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/supplier.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/routes.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

int? logged;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('background title: ${message.notification!.title}');
  print('background body: ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserDatabaseAdapter());
  Hive.registerAdapter(NotificationDatabaseAdapter());

  await SharedPrefs.init();
  logged = SharedPrefs.getInt('logged');

  await FlutterAppBadger.isAppBadgeSupported().then((isSupported) async {
    if (isSupported == true) {
      await FlutterAppBadger.removeBadge();
    }
  });

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => FeedProvider()),
        ChangeNotifierProvider(create: (context) => OperationProvider()),
        ChangeNotifierProvider(create: (context) => ReadingProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => AccountingProvider()),
        ChangeNotifierProvider(create: (context) => SupplierProvider()),
        ChangeNotifierProvider(create: (context) => LoaderProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        routes: Routes.buildRoutes(),
        initialRoute: (logged == 0 || logged == null) ? '/login' : '/',
      ),
    );
  }
}
