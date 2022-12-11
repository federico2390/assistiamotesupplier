import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/repository/user.dart';
import 'package:adminpanel/screens/login/widgets/login_form.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/secure_storage.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadRememberData();
    super.initState();
  }

  void _loadRememberData() async {
    int? rememberData = SharedPrefs.getInt('rememberData');
    print(rememberData);

    if (rememberData != 0 || rememberData != null) {
      if (await SecureStorage.containsKey('username') &&
          await SecureStorage.containsKey('password')) {
        usernameController.text = (await SecureStorage.read('username'));
        passwordController.text = (await SecureStorage.read('password'));
      }
    }

    context.read<LoginProvider>().loadRememberData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: LoginForm(
          formKey: formKey,
          usernameController: usernameController,
          passwordController: passwordController,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: AppConst.padding, right: AppConst.padding, bottom: 45),
          child: Button(
            text: 'Accedi',
            color: usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty
                ? null
                : AppColors.secondaryColor,
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  UserRepository().isLogged == false) {
                hideKeyboard(context);
                UserRepository().login(
                    context, usernameController.text, passwordController.text);
              } else {
                Alerts.errorAlert(context,
                    title: 'Ops!', subtitle: 'Completa tutti i campi');
              }
            },
          ),
        ),
      ),
    );
  }
}
