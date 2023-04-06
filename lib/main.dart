import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/globals/theme.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/search.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/routes.dart';
import 'package:adminpanel/utils/shared_preference.dart';

int? logged;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('background title: ${message.notification!.title}');
  print('background body: ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(UserDatabaseAdapter());

    await FlutterAppBadger.isAppBadgeSupported().then((isSupported) async {
      if (isSupported == true) {
        await FlutterAppBadger.removeBadge();
      }
    });
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBENwkhi_FHpHpnS55c7SHrnFFUt5BfQvk",
      authDomain: "studio-suriano.firebaseapp.com",
      projectId: "studio-suriano",
      storageBucket: "studio-suriano.appspot.com",
      messagingSenderId: "218637504224",
      appId: "1:218637504224:web:3d95f5db4e0efe76bb8a85",
    ));

    Hive.initFlutter();
    Hive.registerAdapter(UserDatabaseAdapter());
  }

  await SharedPrefs.init();
  logged = SharedPrefs.getInt('logged');

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
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => OperationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => LoaderProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => GalleryProvider()),
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
