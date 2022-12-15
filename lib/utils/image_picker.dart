import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

buildImagePicker(BuildContext context, provider) async {
  final ImagePicker picker = ImagePicker();

  Platform.isAndroid
      ? showMaterialModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Wrap(
            children: [
              ListTile(
                title: const Text('Galleria'),
                onTap: () async {
                  final List<XFile> selectedImages =
                      await picker.pickMultiImage(
                    maxHeight: AppConst.imagePickerHeight,
                    maxWidth: AppConst.imagePickerWidth,
                    imageQuality: AppConst.imagePickerQuality,
                    requestFullMetadata: false,
                  );
                  if (provider == OperationProvider) {
                    if (context.read<OperationProvider>().images.length +
                            selectedImages.length >
                        3) {
                      Navigator.pop(context);
                      Alerts.errorAlert(context,
                          title: 'Attenzione', subtitle: 'Max 3 foto');
                      return;
                    }
                    if (selectedImages.isNotEmpty) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    }
                  } else {
                    if (context.read<ReadingProvider>().images.length +
                            selectedImages.length >
                        3) {
                      Navigator.pop(context);
                      Alerts.errorAlert(context,
                          title: 'Attenzione', subtitle: 'Max 3 foto');
                      return;
                    }
                    if (selectedImages.isNotEmpty) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Camera'),
                onTap: () async {
                  final XFile? selectedImages = await picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: AppConst.imagePickerHeight,
                    maxWidth: AppConst.imagePickerWidth,
                    imageQuality: AppConst.imagePickerQuality,
                    requestFullMetadata: false,
                  );
                  // if (selectedImages.length > 3) {
                  //   Alerts.errorAlert(context,
                  //       title: 'Attenzione', subtitle: 'Max 3 foto');
                  //   return;
                  // }
                  if (selectedImages != null) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImage(selectedImages);
                    } else {
                      context.read<ReadingProvider>().addImage(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text('Annulla',
                    style: TextStyle(color: AppColors.errorColor)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      : showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: const Text('Seleziona un opzione'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text(
                  'Galleria',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
                onPressed: () async {
                  final List<XFile> selectedImages =
                      await picker.pickMultiImage(
                    maxHeight: AppConst.imagePickerHeight,
                    maxWidth: AppConst.imagePickerWidth,
                    imageQuality: AppConst.imagePickerQuality,
                    requestFullMetadata: false,
                  );

                  if (provider == OperationProvider) {
                    if (context.read<OperationProvider>().images.length +
                            selectedImages.length >
                        3) {
                      Navigator.pop(context);
                      Alerts.errorAlert(context,
                          title: 'Attenzione', subtitle: 'Max 3 foto');
                      return;
                    }
                    if (selectedImages.isNotEmpty) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    }
                  } else {
                    if (context.read<ReadingProvider>().images.length +
                            selectedImages.length >
                        3) {
                      Navigator.pop(context);
                      Alerts.errorAlert(context,
                          title: 'Attenzione', subtitle: 'Max 3 foto');
                      return;
                    }
                    if (selectedImages.isNotEmpty) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                  }
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Camera',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
                onPressed: () async {
                  final XFile? selectedImages = await picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: AppConst.imagePickerHeight,
                    maxWidth: AppConst.imagePickerWidth,
                    imageQuality: AppConst.imagePickerQuality,
                    requestFullMetadata: false,
                  );
                  // if (selectedImages.length > 3) {
                  //   Alerts.errorAlert(context,
                  //       title: 'Attenzione', subtitle: 'Max 3 foto');
                  //   return;
                  // }
                  if (selectedImages != null) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImage(selectedImages);
                    } else {
                      context.read<ReadingProvider>().addImage(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text(
                'Annulla',
                style: TextStyle(fontSize: 17, color: AppColors.errorColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
}
