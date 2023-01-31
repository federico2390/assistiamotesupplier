import 'package:adminpanel/models/feed.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:image_picker/image_picker.dart';

class GalleryArguments {
  final List<XFile> gallery;
  final List<String>? images;

  GalleryArguments(this.gallery, {this.images});
}

class FeedArguments {
  final Feed feed;

  FeedArguments(this.feed);
}

class OperationArguments {
  final Operation operation;

  OperationArguments(this.operation);
}
