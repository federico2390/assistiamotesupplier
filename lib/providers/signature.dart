// ignore_for_file: prefer_final_fields

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureProvider extends ChangeNotifier {
  SignatureController _signatureController = SignatureController();
  SignatureController get signatureController => _signatureController;

  bool _isSignatureEmpty = false;
  bool get isSignatureEmpty => _isSignatureEmpty;

  void checkSignature() {
    _isSignatureEmpty = _signatureController.isEmpty;
    notifyListeners();
  }

  void clearCanvas() {
    _signatureController.clear();
    checkSignature();
  }

  Future<Uint8List?> exportAsPng() {
    return _signatureController.toPngBytes();
  }
}
