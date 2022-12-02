// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class OperationProvider extends ChangeNotifier {
  List<Media> _images = [];
  List<Media> get images => _images;

  void addImages(List<Media> selectedImages) {
    _images.addAll(selectedImages);
    notifyListeners();
  }

  void removeImage(Media image) {
    _images.removeWhere((i) => i.path == image.path);
    notifyListeners();
  }
}
