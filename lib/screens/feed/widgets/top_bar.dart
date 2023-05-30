import 'package:adminpanel/providers/operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

appBar(BuildContext context) {
  return AppBar(
    leading: Ink(
      child: GestureDetector(
        child: const Icon(Icons.arrow_back_rounded),
        onTap: () {
          context.read<OperationProvider>().removeAllImage();
          context.read<OperationProvider>().descriptionController.clear();
          Navigator.of(context).pop();
        },
      ),
    ),
    title: const Text('Dettagli'),
  );
}
