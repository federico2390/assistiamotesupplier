import 'dart:io';

import 'package:adminpanel/configs/theme.dart';
import 'package:adminpanel/database/user.dart';
import 'package:adminpanel/providers/app_bar.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/routes.dart';
import 'package:adminpanel/utils/scroll_behavior.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

int? logged;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserDatabaseAdapter());

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
        ChangeNotifierProvider<AppBarProvider>(
            create: (context) => AppBarProvider()),
        ChangeNotifierProvider<BottomBarProvider>(
            create: (context) => BottomBarProvider()),
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<OperationProvider>(
            create: (context) => OperationProvider()),
        ChangeNotifierProvider<ReadingProvider>(
            create: (context) => ReadingProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: child!,
          );
        },
        theme: AppTheme.theme(),
        routes: Routes.buildRoutes(),
        initialRoute: (logged == 0 || logged == null) ? '/login' : '/',
      ),
    );
  }
}
