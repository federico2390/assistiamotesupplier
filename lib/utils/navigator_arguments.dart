import 'package:images_picker/images_picker.dart';

class GalleryArguments {
  final List<Media> gallery;

  GalleryArguments(this.gallery);
}

class AccountingArguments {
  final String title;
  final String url;

  AccountingArguments(this.title, this.url);
}
