import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:provider/provider.dart';

buildImagePicker(BuildContext context, provider) async {
  int imageCount = provider == OperationProvider
      ? context.read<OperationProvider>().images.isEmpty
          ? 3
          : context.read<OperationProvider>().images.length == 1
              ? 2
              : context.read<OperationProvider>().images.length == 2
                  ? 1
                  : 0
      : context.read<ReadingProvider>().images.isEmpty
          ? 3
          : context.read<ReadingProvider>().images.length == 1
              ? 2
              : context.read<ReadingProvider>().images.length == 2
                  ? 1
                  : 0;

  List<Asset>? selectedImages = await MultipleImagesPicker.pickImages(
    maxImages: imageCount,
    enableCamera: true,
    cupertinoOptions: const CupertinoOptions(
      takePhotoIcon: "chat",
    ),
    materialOptions: const MaterialOptions(
      actionBarColor: "#abcdef",
      actionBarTitle: AppConst.appName,
      allViewTitle: "Tutte",
      useDetailsView: false,
      selectCircleStrokeColor: "#000000",
    ),
  );

  if (provider == OperationProvider) {
    context.read<OperationProvider>().addImages(selectedImages);
  } else if (provider == ReadingProvider) {
    context.read<ReadingProvider>().addImages(selectedImages);
  }
}
