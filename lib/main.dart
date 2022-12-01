import 'package:adminpanel/configs/theme.dart';
import 'package:adminpanel/providers/app_barr.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
         ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<AppBarProvider>(
            create: (context) => AppBarProvider()),
        ChangeNotifierProvider<BottomBarProvider>(
            create: (context) => BottomBarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        routes: Routes.buildRoutes(),
        initialRoute: '/',
      ),
    );
  }
}
