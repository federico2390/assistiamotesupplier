import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/screens/operation/widgets/operation_form.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: context.watch<CentralProvider>().loading,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: const Scaffold(
          body: OperationForm(),
        ),
      ),
    );
  }
}
