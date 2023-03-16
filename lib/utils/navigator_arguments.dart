import 'package:image_picker/image_picker.dart';

import 'package:adminpanel/models/operation.dart';

class GalleryArguments {
  final List<XFile> gallery;
  final List<String>? images;

  GalleryArguments(this.gallery, {this.images});
}

class OperationArguments {
  final Operation operation;

  OperationArguments(this.operation);
}
