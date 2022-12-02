import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

buildActionSheet(BuildContext context, provider) {
  Platform.isAndroid
      ? showMaterialModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Wrap(
            children: [
              ListTile(
                title: const Text('Galleria'),
                onTap: () async {
                  List<Media>? selectedImages = await ImagesPicker.pick(
                    count: 3,
                    pickType: PickType.image,
                    quality: 0.8,
                    maxSize: 100,
                  );
                  if (selectedImages!.isNotEmpty) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    } else if (provider == ReadingProvider) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
              ),
              ListTile(
                title: const Text('Camera'),
                onTap: () async {
                  List<Media>? selectedImages = await ImagesPicker.openCamera(
                    pickType: PickType.image,
                    quality: 0.8,
                    maxSize: 100,
                  );
                  if (selectedImages!.isNotEmpty) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    } else if (provider == ReadingProvider) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    return;
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
            title: const Text('Aggiungi allegato'),
            message: const Text('Scegli un opzione'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text(
                  'Galleria',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () async {
                  List<Media>? selectedImages = await ImagesPicker.pick(
                    count: 3,
                    pickType: PickType.image,
                    quality: 0.8,
                    maxSize: 100,
                  );
                  if (selectedImages!.isNotEmpty) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    } else if (provider == ReadingProvider) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
              ),
              CupertinoActionSheetAction(
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () async {
                  List<Media>? selectedImages = await ImagesPicker.openCamera(
                    pickType: PickType.image,
                    quality: 0.8,
                    maxSize: 100,
                  );
                  if (selectedImages!.isNotEmpty) {
                    if (provider == OperationProvider) {
                      context
                          .read<OperationProvider>()
                          .addImages(selectedImages);
                    } else if (provider == ReadingProvider) {
                      context.read<ReadingProvider>().addImages(selectedImages);
                    }
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text(
                  'Annulla',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
}
