// ignore_for_file: prefer_final_fields

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class OperationProvider extends ChangeNotifier {
  List<Operation> _operations = [];
  List<Operation> get operations => _operations;

  Future<List<Operation>> getOperations() async {
    List<Operation> operationList = await OperationApi().getOperations();

    operationList.sort(
      (a, b) => DateTime.parse(
        DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(b.operationLastUpdate!.isNotEmpty
                ? b.operationLastUpdate!
                : b.operationDatetime!)
            .toIso8601String(),
      ).compareTo(
        DateTime.parse(
          DateFormat('dd/MM/yyyy HH:mm:ss')
              .parse(a.operationLastUpdate!.isNotEmpty
                  ? a.operationLastUpdate!
                  : a.operationDatetime!)
              .toIso8601String(),
        ),
      ),
    );

    _operations = operationList;
    notifyListeners();
    return _operations;
  }

  XFile? _image;
  XFile get image => _image!;

  void addImage(XFile selectedImage) {
    _image = selectedImage;
    _images.add(_image!);
    notifyListeners();
  }

  List<XFile> _images = [];
  List<XFile> get images => _images;

  void addImages(List<XFile> selectedImages) {
    _images.addAll(selectedImages);
    notifyListeners();
  }

  void removeImage(XFile image) {
    _images.removeWhere((i) => i == image);
    notifyListeners();
  }

  void removeAllImage() {
    _image = null;
    _images.clear();
    notifyListeners();
  }
}
