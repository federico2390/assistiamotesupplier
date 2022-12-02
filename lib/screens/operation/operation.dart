import 'package:adminpanel/screens/operation/widgets/operation_form.dart';
import 'package:adminpanel/screens/operation/widgets/send_button.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';

class Operation extends StatefulWidget {
  const Operation({super.key});

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: OperationForm(),
        bottomNavigationBar: const SendButton(),
      ),
    );
  }
}
