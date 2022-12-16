import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/screens/reading/widgets/reading_form.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: context.watch<CentralProvider>().loading,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: const Scaffold(
          body: ReadingForm(),
        ),
      ),
    );
  }
}
