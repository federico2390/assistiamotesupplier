// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureProvider extends ChangeNotifier {
  SignatureController _signatureController = SignatureController();
  SignatureController get signatureController => _signatureController;

  void clearCanvas() {
    _signatureController.clear();
  }
}
