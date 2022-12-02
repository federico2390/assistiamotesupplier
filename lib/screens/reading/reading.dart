import 'package:adminpanel/screens/reading/widgets/reading_form.dart';
import 'package:adminpanel/screens/reading/widgets/send_button.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ReadingForm(),
        bottomNavigationBar: const SendButton(),
      ),
    );
  }
}
