import 'dart:io';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class OperationDetail extends StatelessWidget {
  const OperationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final operationArguments =
        ModalRoute.of(context)!.settings.arguments as OperationArguments;

    final TextEditingController descriptionController = TextEditingController();
    final FocusNode descriptionNode = FocusNode();

    var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    int userMin = 0;
    int supplierMin = 0;

    bool isIPad = false;

    if (Platform.isIOS) {
      final size = MediaQuery.of(context).size;
      if (size.width > 768) {
        isIPad = true;
      }
    }

    return Consumer<OperationProvider>(
      builder: (context, operationProvider, child) {
        Operation operation = operationProvider.operations
            .firstWhere((e) => e.operationId == operationArguments.operationId);

        return GestureDetector(
          onTap: () => hideKeyboard(context),
          child: Scaffold(
            appBar: appBar(context),
            body: Column(
              children: [
                const SizedBox(height: AppConst.padding / 2),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConst.padding),
                    children: [
                      operation.operationState == 'false'
                          ? Row(
                              children: [
                                operation.operationWorking == 'false'
                                    ? TapDebouncer(
                                        onTap: () async {
                                          await OperationApi()
                                              .markOperationAsWorking(
                                                  context, operation, 'true')
                                              .whenComplete(() {
                                            descriptionController.clear();
                                            context
                                                .read<OperationProvider>()
                                                .removeAllImage();
                                            hideKeyboard(context);
                                            Navigator.of(context).pop(context);
                                          });
                                        },
                                        builder: (BuildContext context,
                                            TapDebouncerFunc? onTap) {
                                          return Expanded(
                                            child: Button(
                                              color: AppColors.attentionColor,
                                              text: 'In corso',
                                              onPressed: onTap,
                                            ),
                                          );
                                        },
                                      )
                                    : const SizedBox(),
                                operation.operationWorking == 'false'
                                    ? const SizedBox(width: AppConst.padding)
                                    : const SizedBox(),
                                TapDebouncer(
                                  onTap: () async {
                                    await OperationApi()
                                        .markOperationAsClosed(
                                            context, operation, 'true')
                                        .whenComplete(() {
                                      descriptionController.clear();
                                      context
                                          .read<OperationProvider>()
                                          .removeAllImage();
                                      hideKeyboard(context);
                                      Navigator.of(context).pop(context);
                                    });
                                  },
                                  builder: (BuildContext context,
                                      TapDebouncerFunc? onTap) {
                                    return Expanded(
                                      child: Button(
                                        color: AppColors.primaryColor,
                                        text: 'Chiudi',
                                        onPressed: onTap,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(),
                      operation.operationState == 'false'
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.operationState == 'false'
                          ? Divider(
                              height: 1,
                              color: AppColors.secondaryColor,
                            )
                          : const SizedBox(),
                      operation.operationState == 'false'
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.media!.isNotEmpty
                          ? Text(
                              'Allegati utente',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                            )
                          : const SizedBox(),
                      operation.media!.isNotEmpty
                          ? const SizedBox(height: AppConst.padding / 2)
                          : const SizedBox(),
                      operation.media!.isNotEmpty
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
                                        scrollPhysics:
                                            const ClampingScrollPhysics(),
                                        itemCount: operation.media!
                                            .where((e) => e.isNotEmpty)
                                            .toList()
                                            .length,
                                        builder:
                                            (BuildContext context, int index) {
                                          return PhotoViewGalleryPageOptions(
                                            key: ValueKey(operation.media!
                                                .where((e) => e.isNotEmpty)
                                                .toList()[index]),
                                            imageProvider: NetworkImage(
                                              operation.media!
                                                  .where((e) => e.isNotEmpty)
                                                  .toList()[index]
                                                  .toString(),
                                            ),
                                            initialScale: PhotoViewComputedScale
                                                .contained,
                                            minScale:
                                                PhotoViewComputedScale.covered,
                                            maxScale:
                                                PhotoViewComputedScale.covered,
                                            disableGestures: true,
                                            heroAttributes:
                                                PhotoViewHeroAttributes(
                                                    tag: operation.media!
                                                        .where(
                                                            (e) => e.isNotEmpty)
                                                        .toList()[index]),
                                            scaleStateCycle: (e) {
                                              switch (e) {
                                                case PhotoViewScaleState
                                                    .initial:
                                                  return PhotoViewScaleState
                                                      .covering;
                                                case PhotoViewScaleState
                                                    .covering:
                                                case PhotoViewScaleState
                                                    .zoomedIn:
                                                case PhotoViewScaleState
                                                    .zoomedOut:
                                                case PhotoViewScaleState
                                                    .originalSize:
                                                  return PhotoViewScaleState
                                                      .initial;
                                              }
                                            },
                                          );
                                        },
                                        onPageChanged: (int index) {
                                          userMin = index;
                                        },
                                        loadingBuilder: (context, event) =>
                                            Center(
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
                                          images: operation.media!,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppConst.padding),
                                  Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: userMin,
                                      count: operation.media!
                                          .where((e) => e.isNotEmpty)
                                          .toList()
                                          .length,
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
                                ],
                              ),
                            )
                          : const SizedBox(),
                      operation.media!.isNotEmpty
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
                          ReadMoreText(
                            operation.description!,
                            trimLines: 1,
                            colorClickableText: AppColors.labelDarkColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '  altro',
                            trimExpandedText: '   meno',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            moreStyle: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            lessStyle: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
                            'Tipo di richiesta',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Text(
                            operation.operation!,
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
                            'Indirizzo',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Text(
                            operation.palaceAddress!,
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
                            endDateTimeFormat.format(startDateTimeFormat
                                .parse(operation.operationDatetime!)),
                          ),
                        ],
                      ),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
                          ? Divider(
                              height: 1,
                              color: AppColors.secondaryColor,
                            )
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isEmpty)
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isEmpty) &&
                              operation.operationState == 'false'
                          ? Divider(
                              height: 1,
                              color: AppColors.secondaryColor,
                            )
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isEmpty) &&
                              operation.operationState == 'false'
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty) &&
                              operation.operationState == 'false'
                          ? Text(
                              'I tuoi allegati',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                            )
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
                          ? const SizedBox(height: AppConst.padding / 2)
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
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
                                        scrollPhysics:
                                            const ClampingScrollPhysics(),
                                        itemCount: operation.supplierMedia!
                                            .where((e) => e.isNotEmpty)
                                            .toList()
                                            .length,
                                        builder:
                                            (BuildContext context, int index) {
                                          return PhotoViewGalleryPageOptions(
                                            key: ValueKey(operation
                                                .supplierMedia!
                                                .where((e) => e.isNotEmpty)
                                                .toList()[index]),
                                            imageProvider: NetworkImage(
                                                operation.supplierMedia!
                                                    .where((e) => e.isNotEmpty)
                                                    .toList()[index]),
                                            initialScale: PhotoViewComputedScale
                                                .contained,
                                            minScale:
                                                PhotoViewComputedScale.covered,
                                            maxScale:
                                                PhotoViewComputedScale.covered,
                                            heroAttributes:
                                                PhotoViewHeroAttributes(
                                                    tag: operation
                                                        .supplierMedia!
                                                        .where(
                                                            (e) => e.isNotEmpty)
                                                        .toList()[index]),
                                            scaleStateCycle: (e) {
                                              switch (e) {
                                                case PhotoViewScaleState
                                                    .initial:
                                                  return PhotoViewScaleState
                                                      .covering;
                                                case PhotoViewScaleState
                                                    .covering:
                                                case PhotoViewScaleState
                                                    .zoomedIn:
                                                case PhotoViewScaleState
                                                    .zoomedOut:
                                                case PhotoViewScaleState
                                                    .originalSize:
                                                  return PhotoViewScaleState
                                                      .initial;
                                              }
                                            },
                                          );
                                        },
                                        onPageChanged: (int index) {
                                          supplierMin = index;
                                        },
                                        loadingBuilder: (context, event) =>
                                            Center(
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
                                          .currentMediaIndex(supplierMin);
                                      Navigator.pushNamed(
                                        context,
                                        '/gallery',
                                        arguments: GalleryArguments(
                                          [],
                                          images: operation.supplierMedia!,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppConst.padding),
                                  Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: supplierMin,
                                      count: operation.supplierMedia!
                                          .where((e) => e.isNotEmpty)
                                          .toList()
                                          .length,
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
                                ],
                              ),
                            )
                          : const SizedBox(),
                      operation.supplierMedia!.any((e) => e.isNotEmpty)
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.operationState == 'false' &&
                              operation.supplierMedia!.any((e) => e.isEmpty)
                          ? Text(
                              'Aggiungi allegati',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                            )
                          : const SizedBox(),
                      operation.operationState == 'false' &&
                              operation.supplierMedia!.any((e) => e.isEmpty)
                          ? const SizedBox(height: AppConst.padding / 2)
                          : const SizedBox(),
                      operation.operationState == 'false' &&
                              operation.supplierMedia!.any((e) => e.isEmpty)
                          ? GridView(
                              padding: const EdgeInsets.only(
                                  bottom: AppConst.padding),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              clipBehavior: Clip.none,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisCount: isIPad == true ? 7 : 3),
                              children: [
                                null,
                                ...context.watch<OperationProvider>().images
                              ].map(
                                (image) {
                                  if (image == null) {
                                    return Button(
                                      color: AppColors.secondaryColor
                                          .withOpacity(.5),
                                      icon: const Icon(
                                        Icons.add_rounded,
                                        size: 44,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        if (context
                                                .read<OperationProvider>()
                                                .images
                                                .length ==
                                            3) {
                                          await Alerts.errorAlert(context,
                                              title: 'Attenzione',
                                              subtitle: 'Max 3 foto');
                                          return;
                                        } else {
                                          buildImagePicker(context,
                                              OperationProvider, operation);
                                        }
                                      },
                                    );
                                  }
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Image.file(File(image.path),
                                              height: 80, fit: BoxFit.cover),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GalleryProvider>()
                                              .currentMediaIndex(context
                                                  .read<OperationProvider>()
                                                  .images
                                                  .indexOf(image));

                                          Navigator.pushNamed(
                                            context,
                                            '/gallery',
                                            arguments: GalleryArguments(
                                              context
                                                  .read<OperationProvider>()
                                                  .images,
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: SizedBox(
                                          height: 27,
                                          width: 27,
                                          child: Button(
                                              color: AppColors.errorColor,
                                              icon: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<OperationProvider>()
                                                    .removeImage(image);
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            )
                          : const SizedBox(),
                      operation.operationState == 'false'
                          ? operation.supplierDescription!.isEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Inserisci una descrizione di fine lavoro',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: AppConst.padding),
                                    TextFormField(
                                      controller: descriptionController,
                                      focusNode: descriptionNode,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      enableInteractiveSelection: true,
                                      selectionControls:
                                          MaterialTextSelectionControls(),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Il campo non può essere vuoto';
                                        }
                                        return null;
                                      },
                                      maxLines: null,
                                      maxLength: 1000,
                                      decoration: InputDecoration(
                                        labelText: 'Descrizione',
                                        labelStyle: TextStyle(
                                            color: AppColors.secondaryColor),
                                        alignLabelWithHint: true,
                                        suffixIcon: descriptionController
                                                .text.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  descriptionController.clear();
                                                },
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                              )
                                            : null,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.focusedColor),
                                          borderRadius: BorderRadius.circular(
                                              AppConst.borderRadius),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.secondaryColor),
                                          borderRadius: BorderRadius.circular(
                                              AppConst.borderRadius),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: AppColors.errorColor),
                                          borderRadius: BorderRadius.circular(
                                              AppConst.borderRadius),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.errorColor),
                                          borderRadius: BorderRadius.circular(
                                              AppConst.borderRadius),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Descrizione',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                    ReadMoreText(
                                      operation.supplierDescription!,
                                      trimLines: 1,
                                      colorClickableText:
                                          AppColors.labelDarkColor,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: '  altro',
                                      trimExpandedText: '   meno',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      moreStyle: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      lessStyle: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                          : const SizedBox(),
                      operation.operationState == 'false' &&
                                  operation.supplierDescription!.isEmpty ||
                              operation.supplierMedia!.any((e) => e.isEmpty)
                          ? const SizedBox(height: AppConst.padding)
                          : const SizedBox(),
                      operation.operationState == 'false'
                          ? operation.supplierDescription!.isEmpty ||
                                  operation.supplierMedia!.any((e) => e.isEmpty)
                              ? TapDebouncer(
                                  onTap: () async {
                                    if (descriptionController.text.isNotEmpty ||
                                        context
                                                .read<OperationProvider>()
                                                .images
                                                .isNotEmpty &&
                                            operation.operationState ==
                                                'false') {
                                      await OperationApi()
                                          .editOperation(
                                        context,
                                        operation,
                                        descriptionController.text,
                                      )
                                          .whenComplete(() {
                                        descriptionController.clear();
                                        context
                                            .read<OperationProvider>()
                                            .removeAllImage();
                                        hideKeyboard(context);
                                      });
                                    }
                                  },
                                  builder: (BuildContext context,
                                      TapDebouncerFunc? onTap) {
                                    return Button(
                                      color: descriptionController
                                                  .text.isNotEmpty ||
                                              context
                                                      .read<OperationProvider>()
                                                      .images
                                                      .isNotEmpty &&
                                                  operation.operationState ==
                                                      'false'
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryColor
                                              .withOpacity(.5),
                                      text: 'Salva',
                                      onPressed: onTap,
                                    );
                                  },
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      const SizedBox(height: AppConst.padding * 3)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
