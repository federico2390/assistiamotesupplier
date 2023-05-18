import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/screens/login/widgets/login_form.dart';
import 'package:adminpanel/utils/shared_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadRememberData();
    usernameController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loadRememberData() async {
    int? rememberData = SharedPrefs.getInt('rememberData');

    if (rememberData != 0 || rememberData != null) {
      final user = await context.read<UserProvider>().getLocalUser();
      if (user.supplierEmail != null && user.supplierCf != null) {
        usernameController.text = user.supplierEmail!;
        passwordController.text = user.supplierCf!;
      }
    }

    context.read<LoginProvider>().loadRememberData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => kIsWeb ? false : true,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Scaffold(
          body: LoginForm(
            formKey: formKey,
            usernameController: usernameController,
            passwordController: passwordController,
          ),
        ),
      ),
    );
  }
}
