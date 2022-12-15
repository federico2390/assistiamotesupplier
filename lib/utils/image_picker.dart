import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:provider/provider.dart';

buildImagePicker(BuildContext context, provider) async {
  List<Asset>? selectedImages = await MultipleImagesPicker.pickImages(
    maxImages: 3,
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
