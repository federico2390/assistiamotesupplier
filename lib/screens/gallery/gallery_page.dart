import 'package:adminpanel/screens/gallery/widgets/app_bar.dart';
import 'package:adminpanel/screens/gallery/widgets/photo_gallery.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: const PhotoGallery(),
    );
  }
}
