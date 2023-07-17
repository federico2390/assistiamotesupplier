import 'package:adminpanel/models/operation.dart';
import 'package:image_picker/image_picker.dart';

class GalleryArguments {
  final List<XFile>? gallery;
  final List<String>? images;
  final bool? isSupplierMedia;

  GalleryArguments({
    this.gallery,
    this.images,
    this.isSupplierMedia,
  });
}

class OperationArguments {
  final String operationId;

  OperationArguments(
    this.operationId,
  );
}

class VisitArguments {
  final Operation? operation;
  final String? visitDescription;
  final String? visitDateTime;
  final int? visitIndex;

  VisitArguments({
    this.operation,
    this.visitDescription,
    this.visitDateTime,
    this.visitIndex,
  });
}
