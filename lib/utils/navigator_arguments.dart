import 'package:image_picker/image_picker.dart';

class GalleryArguments {
  final List<XFile> gallery;
  final List<String>? images;

  GalleryArguments(this.gallery, {this.images});
}

class OperationArguments {
  final String operationId;

  OperationArguments(this.operationId);
}
