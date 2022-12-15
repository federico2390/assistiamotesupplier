import 'package:image_picker/image_picker.dart';

class GalleryArguments {
  final List<XFile> gallery;

  GalleryArguments(this.gallery);
}

class AccountingArguments {
  final String title;
  final String url;

  AccountingArguments(this.title, this.url);
}
