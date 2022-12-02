import 'package:adminpanel/screens/login/widgets/login_form.dart';
import 'package:adminpanel/screens/login/widgets/send_button.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: const Scaffold(
        body: LoginForm(),
        bottomNavigationBar: SendButton(),
      ),
    );
  }
}
