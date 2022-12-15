import 'dart:io';

import 'package:flutter_luban/flutter_luban.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> getImagePath(Asset image) async {
  try {
    /// Get Temporary Directory
    final tempDir = await getTemporaryDirectory();

    /// Get Image Path
    final imagePath =
        await LecleFlutterAbsolutePath.getAbsolutePath(uri: image.identifier!);

    /// Compress Image
    CompressObject compressImage = CompressObject(
      imageFile: File(imagePath!),
      path: tempDir.path,
      mode: CompressMode.AUTO,
      quality: 80,
      step: 6,
      autoRatio: true,
    );

    /// Return Compressed Image
    final result = Luban.compressImage(compressImage);
    return result;
  } catch (error) {
    print(error);
  }
  return null;
}
