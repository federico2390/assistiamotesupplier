import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/screens/feed/widgets/top_bar.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/image_picker.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';

class OperationDetail extends StatelessWidget {
  const OperationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final operationArguments =
        ModalRoute.of(context)!.settings.arguments as OperationArguments;

    var startDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    var endDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    bool isIPad = false;

    if (kIsWeb || Platform.isIOS) {
      final size = MediaQuery.of(context).size;
      if (size.width > 768) {
        isIPad = true;
      }
    }

    return WillPopScope(
      onWillPop: () async => kIsWeb ? false : true,
      child: GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Scaffold(
          appBar: appBar(context),
          body: body(
            operationArguments,
            endDateTimeFormat,
            startDateTimeFormat,
            isIPad,
          ),
        ),
      ),
    );
  }

  Consumer<OperationProvider> body(
    OperationArguments operationArguments,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
    bool isIPad,
  ) {
    return Consumer<OperationProvider>(
      builder: (context, operationProvider, child) {
        Operation operation = operationProvider.operations
            .firstWhere((e) => e.operationId == operationArguments.operationId);

        return refreshPage(
          context,
          operation,
          endDateTimeFormat,
          startDateTimeFormat,
          isIPad,
        );
      },
    );
  }

  RefreshIndicator refreshPage(
    BuildContext context,
    Operation operation,
    DateFormat endDateTimeFormat,
    DateFormat startDateTimeFormat,
    bool isIPad,
  ) {
    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () => context.read<StateProvider>().buildFuture(context),
      child: Column(
        children: [
          const SizedBox(height: AppConst.padding / 2),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: AppConst.padding),
              children: [
                operation.operationState == 'false'
                    ? workingAndCloseButtons(operation, context)
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
                    ? userMedia(context, operation)
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
                    description(operation),
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
                      'Richiedente',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Text(
                      operation.requestBy!,
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
                const SizedBox(height: AppConst.padding),
                operation.supplierMedia!.any((e) => e.isNotEmpty) &&
                        operation.operationState == 'true'
                    ? Divider(
                        height: 1,
                        color: AppColors.secondaryColor,
                      )
                    : const SizedBox(),
                operation.supplierMedia!.any((e) => e.isEmpty) &&
                        operation.operationState == 'false'
                    ? Divider(
                        height: 1,
                        color: AppColors.secondaryColor,
                      )
                    : const SizedBox(),
                const SizedBox(height: AppConst.padding),
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
                    ? supplierMedia(context, operation)
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
                    ? addMedia(isIPad, context, operation)
                    : const SizedBox(),
                operation.supplierDescription!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrizione',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          supplierDescription(operation),
                        ],
                      )
                    : descriptionField(context),
                operation.operationState == 'false' &&
                            operation.supplierDescription!.isEmpty ||
                        operation.supplierMedia!.any((e) => e.isEmpty)
                    ? const SizedBox(height: AppConst.padding)
                    : const SizedBox(),
                operation.operationState == 'false'
                    ? operation.supplierDescription!.isEmpty ||
                            operation.supplierMedia!.any((e) => e.isEmpty)
                        ? saveButton(context, operation)
                        : const SizedBox()
                    : const SizedBox(),
                const SizedBox(height: AppConst.padding * 3)
              ],
            ),
          ),
        ],
      ),
    );
  }

  GridView addMedia(bool isIPad, BuildContext context, Operation operation) {
    return GridView(
      padding: const EdgeInsets.only(bottom: AppConst.padding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: isIPad == true ? 7 : 3),
      children: [null, ...context.watch<OperationProvider>().images].map(
        (image) {
          if (image == null) {
            return TapDebouncer(
              onTap: () async {
                if (context.read<OperationProvider>().images.length == 3) {
                  await Alerts.errorAlert(context,
                      title: 'Attenzione', subtitle: 'Max 2 foto');
                  return;
                } else {
                  buildImagePicker(context, OperationProvider, operation);
                }
              },
              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return Button(
                  color: AppColors.secondaryColor.withOpacity(.5),
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                  onPressed: onTap,
                );
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
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        kIsWeb ? AppConst.borderRadius : 8),
                  ),
                  child: kIsWeb
                      ? Image.network(image.path, height: 80, fit: BoxFit.cover)
                      : Image.file(File(image.path),
                          height: 80, fit: BoxFit.cover),
                ),
                onTap: () {
                  context.read<GalleryProvider>().supplierCurrentMediaIndex(
                      context.read<OperationProvider>().images.indexOf(image));

                  Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: GalleryArguments(
                      gallery: context.read<OperationProvider>().images,
                      isSupplierMedia: true,
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
                  child: TapDebouncer(
                    onTap: () async {
                      context.read<OperationProvider>().removeImage(image);
                    },
                    builder: (BuildContext context, TapDebouncerFunc? onTap) {
                      return Button(
                        color: AppColors.errorColor,
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: onTap,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  Column descriptionField(BuildContext context) {
    return Column(
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
          controller: context.read<OperationProvider>().descriptionController,
          focusNode: context.read<OperationProvider>().descriptionNode,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textCapitalization: TextCapitalization.sentences,
          enableInteractiveSelection: true,
          selectionControls: MaterialTextSelectionControls(),
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
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffixIcon: context
                    .read<OperationProvider>()
                    .descriptionController
                    .text
                    .isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      context
                          .read<OperationProvider>()
                          .descriptionController
                          .clear();
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: AppColors.secondaryColor,
                    ),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.focusedColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
          ),
        )
      ],
    );
  }

  ReadMoreText supplierDescription(Operation operation) {
    return ReadMoreText(
      operation.supplierDescription!,
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
    );
  }

  TapDebouncer saveButton(BuildContext context, Operation operation) {
    return TapDebouncer(
      onTap: () async {
        if (context
                .read<OperationProvider>()
                .descriptionController
                .text
                .isNotEmpty ||
            context.read<OperationProvider>().images.isNotEmpty &&
                operation.operationState == 'false') {
          await OperationApi()
              .editOperation(
            context,
            operation,
            context.read<OperationProvider>().descriptionController.text,
          )
              .whenComplete(() {
            context.read<OperationProvider>().descriptionController.clear();
            context.read<OperationProvider>().removeAllImage();
            hideKeyboard(context);
          });
        }
      },
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return Button(
          color: context
                      .read<OperationProvider>()
                      .descriptionController
                      .text
                      .isNotEmpty ||
                  context.read<OperationProvider>().images.isNotEmpty &&
                      operation.operationState == 'false'
              ? AppColors.primaryColor
              : AppColors.secondaryColor.withOpacity(.5),
          text: 'Salva',
          onPressed: onTap,
        );
      },
    );
  }

  GridView supplierMedia(BuildContext context, Operation operation) {
    return GridView(
      padding: const EdgeInsets.only(bottom: AppConst.padding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 3),
      children: [
        ...operation.supplierMedia!.where((e) => e.isNotEmpty).toList().toList()
      ].asMap().entries.map(
        (entry) {
          final index = entry.key;
          final image = entry.value;

          return Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        kIsWeb ? AppConst.borderRadius : 8),
                  ),
                  child: Image.network(
                    key: ValueKey(image),
                    image,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 20.0,
                          color: AppColors.secondaryColor,
                        ),
                      );
                    },
                  ),
                ),
                onTap: () {
                  context
                      .read<GalleryProvider>()
                      .supplierCurrentMediaIndex(index);
                  Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: GalleryArguments(
                      gallery: [],
                      isSupplierMedia: true,
                      images: operation.supplierMedia!
                          .where((e) => e.isNotEmpty)
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  ReadMoreText description(Operation operation) {
    return ReadMoreText(
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
    );
  }

  GridView userMedia(BuildContext context, Operation operation) {
    return GridView(
      padding: const EdgeInsets.only(bottom: AppConst.padding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 3),
      children: [...operation.media!.where((e) => e.isNotEmpty).toList()]
          .asMap()
          .entries
          .map(
        (entry) {
          final index = entry.key;
          final image = entry.value;

          return Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        kIsWeb ? AppConst.borderRadius : 8),
                  ),
                  child: Image.network(
                    key: ValueKey(image),
                    image,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.error_outline_rounded,
                          size: 20.0,
                          color: AppColors.secondaryColor,
                        ),
                      );
                    },
                  ),
                ),
                onTap: () {
                  context.read<GalleryProvider>().userCurrentMediaIndex(index);
                  Navigator.pushNamed(
                    context,
                    '/gallery',
                    arguments: GalleryArguments(
                      gallery: [],
                      isSupplierMedia: false,
                      images:
                          operation.media!.where((e) => e.isNotEmpty).toList(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  Row workingAndCloseButtons(Operation operation, BuildContext context) {
    return Row(
      children: [
        operation.operationWorking == 'false'
            ? TapDebouncer(
                onTap: () async {
                  await Alerts.loadingAlert(context,
                      title: 'Attendi...',
                      subtitle: 'Segno l\'intervento come in corso');

                  await OperationApi()
                      .markOperationAsWorking(context, operation, 'true')
                      .whenComplete(() async {
                    context
                        .read<OperationProvider>()
                        .descriptionController
                        .clear();
                    context.read<OperationProvider>().removeAllImage();
                    hideKeyboard(context);
                    Alerts.hideAlert();
                    await context.read<StateProvider>().buildFuture(context);
                    Navigator.of(context).pop(context);
                  });
                },
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
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
            if (operation.operationWorking == 'false') {
              await Alerts.errorAlert(context,
                  title: 'Attenzione',
                  subtitle: 'Devi prima segnare l\'intervento come In corso');
            } else {
              await Alerts.loadingAlert(context,
                  title: 'Attendi...',
                  subtitle: 'Segno l\'intervento come chiuso');

              await OperationApi()
                  .markOperationAsClosed(context, operation, 'true')
                  .whenComplete(() async {
                context.read<OperationProvider>().descriptionController.clear();
                context.read<OperationProvider>().removeAllImage();
                hideKeyboard(context);
                Alerts.hideAlert();
                await context.read<StateProvider>().buildFuture(context);
                Navigator.of(context).pop(context);
              });
            }
          },
          builder: (BuildContext context, TapDebouncerFunc? onTap) {
            return Expanded(
              child: Button(
                color: AppColors.errorColor,
                text: 'Chiudi',
                onPressed: onTap,
              ),
            );
          },
        ),
      ],
    );
  }
}
