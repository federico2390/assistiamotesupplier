import 'package:adminpanel/screens/operation/widgets/operation_form.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';

class OperationPage extends StatelessWidget {
  const OperationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: const OperationForm(),
    );
  }
}
