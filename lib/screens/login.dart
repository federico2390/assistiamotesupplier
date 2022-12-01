import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(AppConst.padding),
          children: [
            Center(
              child: Image.asset(
                'assets/logo.jpg',
                fit: BoxFit.contain,
                height: ScreenSize.width(context) / 3,
              ),
            ),
            SizedBox(height: AppConst.padding * 2),
            TextFormField(
              controller: usernameController,
              focusNode: usernameFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              toolbarOptions: const ToolbarOptions(
                  copy: true, cut: true, paste: true, selectAll: true),
              decoration: InputDecoration(
                labelText: 'Nome Utente',
                labelStyle: TextStyle(color: AppColors.secondaryColor),
                alignLabelWithHint: true,
                suffix: GestureDetector(
                  child: const Icon(Icons.clear, size: 20),
                  onTap: () => usernameController.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(AppConst.borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(AppConst.borderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColors.errorColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
              ),
            ),
            SizedBox(height: AppConst.padding),
            TextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              obscureText: context.watch<LoginProvider>().hiddenPassword,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              toolbarOptions: const ToolbarOptions(
                  copy: true, cut: true, paste: true, selectAll: true),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: AppColors.secondaryColor),
                alignLabelWithHint: true,
                suffix: SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            context.read<LoginProvider>().hidePassword(),
                        child: Icon(
                          context.watch<LoginProvider>().hiddenPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      SizedBox(width: AppConst.padding / 2),
                      GestureDetector(
                        child: const Icon(Icons.clear, size: 20),
                        onTap: () => passwordController.clear(),
                      ),
                    ],
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(AppConst.borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(AppConst.borderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColors.errorColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondaryColor),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(AppConst.padding),
          child: Button(
            text: 'Accedi',
            onPressed: () => login(context),
          ),
        ),
      ),
    );
  }
}

Future<void> login(BuildContext context) async {
  hideKeyboard(context);
}
