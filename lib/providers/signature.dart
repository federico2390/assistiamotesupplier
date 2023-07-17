// ignore_for_file: prefer_final_fields

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureProvider extends ChangeNotifier {
  SignatureController _signatureController = SignatureController();
  SignatureController get signatureController => _signatureController;

  void clearCanvas() {
    _signatureController.clear();
  }

  Future<Uint8List?> export() async {
    final Uint8List? data =
        await _signatureController.toPngBytes(height: 1000, width: 1000);
    return data;
  }
}
