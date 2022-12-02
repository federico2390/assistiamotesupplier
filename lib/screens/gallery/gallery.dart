import 'package:adminpanel/screens/gallery/widgets/app_bar.dart';
import 'package:adminpanel/screens/gallery/widgets/photo_gallery.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
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
