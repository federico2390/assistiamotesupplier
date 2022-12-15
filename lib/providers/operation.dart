// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class OperationProvider extends ChangeNotifier {
  List<Asset> _images = [];
  List<Asset> get images => _images;

  void addImages(List<Asset> selectedImages) {
    _images.addAll(selectedImages);
    notifyListeners();
  }

  void removeImage(Asset image) {
    _images.removeWhere((i) => i == image);
    notifyListeners();
  }
}
