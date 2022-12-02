import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int min = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: context.read<ReadingProvider>().images.length,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              key: ValueKey(context.read<ReadingProvider>().images[index].path),
              imageProvider: FileImage(
                  File(context.read<ReadingProvider>().images[index].path)),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2.5,
              heroAttributes: PhotoViewHeroAttributes(
                  tag: context.read<ReadingProvider>().images[index].path),
              scaleStateCycle: (e) {
                switch (e) {
                  case PhotoViewScaleState.initial:
                    return PhotoViewScaleState.covering;
                  case PhotoViewScaleState.covering:
                  case PhotoViewScaleState.zoomedIn:
                  case PhotoViewScaleState.zoomedOut:
                  case PhotoViewScaleState.originalSize:
                    return PhotoViewScaleState.initial;
                }
              },
            );
          },
          onPageChanged: (int index) {
            setState(() {
              min = index;
            });
          },
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: SafeArea(
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: min,
                count: context.read<ReadingProvider>().images.length,
                effect: WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Colors.white.withOpacity(.85),
                  dotColor: AppColors.secondaryColor.withOpacity(.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
