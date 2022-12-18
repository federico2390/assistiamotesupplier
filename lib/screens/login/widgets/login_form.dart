import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/login.dart';
import 'package:adminpanel/utils/size.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(AppConst.padding),
        children: [
          SizedBox(height: ScreenSize.height(context) / 4),
          Center(
            child: Image.asset(
              'assets/logo.jpg',
              fit: BoxFit.contain,
              height: ScreenSize.width(context) / 3,
            ),
          ),
          const SizedBox(height: AppConst.padding * 2),
          TextFormField(
            controller: widget.usernameController,
            focusNode: usernameFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enableInteractiveSelection: true,
            toolbarOptions: const ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Nome Utente',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
              suffixIcon: widget.usernameController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.usernameController.clear();
                        });
                      },
                      child: Icon(
                        Icons.cancel_rounded,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.focusedColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.errorColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.errorColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
            ),
          ),
          const SizedBox(height: AppConst.padding),
          TextFormField(
            controller: widget.passwordController,
            focusNode: passwordFocusNode,
            obscureText: context.watch<LoginProvider>().hiddenPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            toolbarOptions: const ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
              suffixIcon: SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              context.read<LoginProvider>().hidePassword(),
                          child: Icon(
                            context.watch<LoginProvider>().hiddenPassword
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        const SizedBox(width: AppConst.padding),
                      ],
                    ),
                    widget.passwordController.text.isNotEmpty
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.passwordController.clear();
                                  });
                                },
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              const SizedBox(width: 12)
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.focusedColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.errorColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.errorColor),
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
              ),
            ),
          ),
          const SizedBox(height: AppConst.padding * 1.5),
          GestureDetector(
            child: Row(
              children: [
                Radio<bool>(
                  value: context.watch<LoginProvider>().rememberData,
                  groupValue: true,
                  toggleable: true,
                  activeColor: AppColors.primaryColor,
                  onChanged: (_) {
                    context.read<LoginProvider>().rememberMyData();
                  },
                ),
                Text(
                  'Ricorda i miei dati di accesso',
                  style: TextStyle(color: AppColors.labelDarkColor),
                )
              ],
            ),
            onTap: () {
              context.read<LoginProvider>().rememberMyData();
            },
          ),
        ],
      ),
    );
  }
}
