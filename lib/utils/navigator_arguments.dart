import 'package:multiple_images_picker/multiple_images_picker.dart';

class GalleryArguments {
  final List<Asset> gallery;

  GalleryArguments(this.gallery);
}

class AccountingArguments {
  final String title;
  final String url;

  AccountingArguments(this.title, this.url);
}
