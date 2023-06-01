import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:uuid/uuid.dart';

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as GalleryArguments;

    return arguments.gallery!.isNotEmpty
        ? Stack(
            children: [
              Consumer<GalleryProvider>(
                builder: (context, galleryProvider, child) {
                  return PhotoViewGallery.builder(
                    pageController: PageController(
                      initialPage: arguments.isSupplierMedia == false
                          ? galleryProvider.userMediaIndex
                          : galleryProvider.supplierMediaIndex,
                    ),
                    scrollPhysics: const BouncingScrollPhysics(),
                    itemCount: arguments.gallery!.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        key: ValueKey(arguments.gallery![index]),
                        imageProvider:
                            FileImage(File(arguments.gallery![index].path)),
                        initialScale: PhotoViewComputedScale.contained,
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2.5,
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: const Uuid().v4(),
                        ),
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
                      arguments.isSupplierMedia == false
                          ? context
                              .read<GalleryProvider>()
                              .userCurrentMediaIndex(index)
                          : context
                              .read<GalleryProvider>()
                              .supplierCurrentMediaIndex(index);
                    },
                    loadingBuilder: (context, event) => Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes!,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: SafeArea(
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: arguments.isSupplierMedia == false
                          ? context.watch<GalleryProvider>().userMediaIndex
                          : context.watch<GalleryProvider>().supplierMediaIndex,
                      count: arguments.gallery!.length,
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
          )
        : Stack(
            children: [
              Consumer<GalleryProvider>(
                builder: (context, galleryProvider, child) {
                  return PhotoViewGallery.builder(
                    pageController: PageController(
                      initialPage: arguments.isSupplierMedia == false
                          ? galleryProvider.userMediaIndex
                          : galleryProvider.supplierMediaIndex,
                    ),
                    scrollPhysics: const BouncingScrollPhysics(),
                    itemCount: arguments.images!.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        key: ValueKey(arguments.images![index]),
                        imageProvider: NetworkImage(arguments.images![index]),
                        initialScale: PhotoViewComputedScale.contained,
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2.5,
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: const Uuid().v4(),
                        ),
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
                      arguments.isSupplierMedia == false
                          ? context
                              .read<GalleryProvider>()
                              .userCurrentMediaIndex(index)
                          : context
                              .read<GalleryProvider>()
                              .supplierCurrentMediaIndex(index);
                    },
                    loadingBuilder: (context, event) => Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes!,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: SafeArea(
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: arguments.isSupplierMedia == false
                          ? context.watch<GalleryProvider>().userMediaIndex
                          : context.watch<GalleryProvider>().supplierMediaIndex,
                      count: arguments.images!.length,
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
