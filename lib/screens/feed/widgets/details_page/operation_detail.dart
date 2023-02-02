import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OperationDetail extends StatefulWidget {
  const OperationDetail({super.key});

  @override
  State<OperationDetail> createState() => _OperationDetailState();
}

class _OperationDetailState extends State<OperationDetail> {
  var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

  int userMin = 0;
  int supplierMin = 0;

  @override
  Widget build(BuildContext context) {
    final operationArguments =
        ModalRoute.of(context)!.settings.arguments as OperationArguments;

    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
              children: [
                operationArguments.operation.media!.isNotEmpty
                    ? SizedBox(
                        height: ScreenSize.width(context) / 2 + 24,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConst.borderRadius)),
                                height: ScreenSize.width(context) / 2,
                                child: PhotoViewGallery.builder(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  itemCount: operationArguments
                                      .operation.media!.length,
                                  builder: (BuildContext context, int index) {
                                    return PhotoViewGalleryPageOptions(
                                      key: ValueKey(operationArguments
                                          .operation.media![index]),
                                      imageProvider: NetworkImage(
                                          operationArguments
                                              .operation.media![index]),
                                      initialScale:
                                          PhotoViewComputedScale.contained,
                                      minScale: PhotoViewComputedScale.covered,
                                      maxScale: PhotoViewComputedScale.covered,
                                      disableGestures: true,
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: operationArguments
                                              .operation.media![index]),
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
                                      userMin = index;
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
                                            : event.cumulativeBytesLoaded /
                                                event.expectedTotalBytes!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                context
                                    .read<GalleryProvider>()
                                    .currentMediaIndex(userMin);
                                Navigator.pushNamed(
                                  context,
                                  '/gallery',
                                  arguments: GalleryArguments(
                                    [],
                                    images: operationArguments.operation.media!,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: AppConst.padding),
                            Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: userMin,
                                count:
                                    operationArguments.operation.media!.length,
                                effect: WormEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor:
                                      AppColors.labelDarkColor.withOpacity(.85),
                                  dotColor:
                                      AppColors.secondaryColor.withOpacity(.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                operationArguments.operation.media!.isNotEmpty
                    ? const SizedBox(height: AppConst.padding)
                    : const SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descrizione',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operationArguments.operation.description!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                Divider(
                  height: 1,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipologia di intervento',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operationArguments.operation.operationType!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipo di richiesta',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operationArguments.operation.operation!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConst.padding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data di inserimento',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      endDateTimeFormat.format(startDateTimeFormat.parse(
                          operationArguments.operation.operationDatetime!)),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? const SizedBox(height: AppConst.padding)
                    : const SizedBox(),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? Divider(
                        height: 1,
                        color: AppColors.secondaryColor,
                      )
                    : const SizedBox(),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? const SizedBox(
                        height: AppConst.padding + AppConst.padding / 3)
                    : const SizedBox(),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? SizedBox(
                        height: ScreenSize.width(context) / 2 + 24,
                        child: Column(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConst.borderRadius)),
                              height: ScreenSize.width(context) / 2,
                              child: PhotoViewGallery.builder(
                                scrollPhysics: const BouncingScrollPhysics(),
                                itemCount: operationArguments
                                    .operation.supplierMedia!.length,
                                builder: (BuildContext context, int index) {
                                  return PhotoViewGalleryPageOptions(
                                    key: ValueKey(operationArguments
                                        .operation.supplierMedia![index]),
                                    imageProvider: NetworkImage(
                                        operationArguments
                                            .operation.supplierMedia![index]),
                                    initialScale:
                                        PhotoViewComputedScale.contained,
                                    minScale: PhotoViewComputedScale.covered,
                                    maxScale: PhotoViewComputedScale.covered,
                                    heroAttributes: PhotoViewHeroAttributes(
                                        tag: operationArguments
                                            .operation.supplierMedia![index]),
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
                                    supplierMin = index;
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
                                          : event.cumulativeBytesLoaded /
                                              event.expectedTotalBytes!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppConst.padding),
                            Positioned(
                              left: AppConst.padding,
                              right: AppConst.padding,
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: supplierMin,
                                  count: operationArguments
                                      .operation.supplierMedia!.length,
                                  effect: WormEffect(
                                    dotWidth: 8,
                                    dotHeight: 8,
                                    activeDotColor: AppColors.labelDarkColor
                                        .withOpacity(.85),
                                    dotColor: AppColors.secondaryColor
                                        .withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? const SizedBox(height: AppConst.padding)
                    : const SizedBox(),
                operationArguments.operation.supplierMedia!.first.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrizione del fornitore',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Text(
                            operationArguments.operation.supplierDescription!,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: AppConst.padding * 2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
