import 'package:flutter/material.dart';

import 'package:adminpanel/screens/reading/widgets/reading_form.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: const ReadingForm(),
    );
  }
}
