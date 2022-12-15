// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReadingProvider extends ChangeNotifier {
  XFile? _image;
  XFile get image => _image!;

  List<XFile> _images = [];
  List<XFile> get images => _images;

  void addImage(XFile selectedImage) {
    _image = selectedImage;
    _images.add(_image!);
    notifyListeners();
  }

  void addImages(List<XFile> selectedImages) {
    _images.addAll(selectedImages);
    notifyListeners();
  }

  void removeImage(XFile image) {
    _images.removeWhere((i) => i == image);
    notifyListeners();
  }
}
