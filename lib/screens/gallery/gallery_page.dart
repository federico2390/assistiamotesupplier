import 'package:adminpanel/screens/gallery/widgets/app_bar.dart';
import 'package:adminpanel/screens/gallery/widgets/photo_gallery.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
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
