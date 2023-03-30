import 'package:flutter/material.dart';

appBar(BuildContext context) {
  return AppBar(
    leading: Ink(
      child: GestureDetector(
        child: const Icon(Icons.arrow_back_rounded),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    title: const Text('Dettagli'),
  );
}
