import 'dart:io';

import 'package:adminpanel/models/operation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/alerts.dart';

buildSign(BuildContext context, provider, Operation operation) async {
  // final ImagePicker picker = ImagePicker();

  // kIsWeb
  //     ? showDialog(
  //         context: context,
  //         useRootNavigator: true,
  //         builder: (BuildContext context) => AlertDialog(
  //           content: Wrap(
  //             children: [
  //               ListTile(
  //                   title: const Text('Galleria'),
  //                   onTap: () async {
  //                     try {
  //                       List<XFile>? selectedImages = await picker
  //                           .pickMultiImage(
  //                         maxHeight: AppConst.imagePickerHeight,
  //                         maxWidth: AppConst.imagePickerWidth,
  //                         imageQuality: AppConst.imagePickerQuality,
  //                         requestFullMetadata: false,
  //                       )
  //                           .catchError((error) {
  //                         throw error;
  //                       });

  //                       if (context.read<OperationProvider>().images.length +
  //                               selectedImages.length +
  //                               operation.supplierMedia!
  //                                   .where((e) => e.isNotEmpty)
  //                                   .length >
  //                           2) {
  //                         Navigator.pop(context);
  //                         await Alerts.errorAlert(context,
  //                             title: 'Attenzione', subtitle: 'Max 2 foto');
  //                         return;
  //                       }
  //                       if (selectedImages.isNotEmpty) {
  //                         context
  //                             .read<OperationProvider>()
  //                             .addImages(selectedImages);
  //                       }
  //                       Navigator.pop(context);
  //                     } catch (error) {
  //                       print('ERROR_pickImage: $error');
  //                     }
  //                   }),
  //               ListTile(
  //                 title: const Text('Camera'),
  //                 onTap: () async {
  //                   try {
  //                     XFile? selectedImages = await picker
  //                         .pickImage(
  //                       source: ImageSource.camera,
  //                       maxHeight: AppConst.imagePickerHeight,
  //                       maxWidth: AppConst.imagePickerWidth,
  //                       imageQuality: AppConst.imagePickerQuality,
  //                       requestFullMetadata: false,
  //                     )
  //                         .catchError((error) {
  //                       throw error;
  //                     });

  //                     if (selectedImages != null) {
  //                       context
  //                           .read<OperationProvider>()
  //                           .addImage(selectedImages);
  //                       Navigator.pop(context);
  //                     }
  //                   } catch (error) {
  //                     print('ERROR_pickImage: $error');
  //                   }
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('Annulla',
  //                     style: TextStyle(color: AppColors.errorColor)),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       )
  //     : Platform.isAndroid
  //         ? showModalBottomSheet(
  //             context: context,
  //             useRootNavigator: true,
  //             builder: (BuildContext context) => Wrap(
  //               children: [
  //                 ListTile(
  //                     title: const Text('Galleria'),
  //                     onTap: () async {
  //                       try {
  //                         List<XFile>? selectedImages = await picker
  //                             .pickMultiImage(
  //                           maxHeight: AppConst.imagePickerHeight,
  //                           maxWidth: AppConst.imagePickerWidth,
  //                           imageQuality: AppConst.imagePickerQuality,
  //                           requestFullMetadata: false,
  //                         )
  //                             .catchError((error) {
  //                           throw error;
  //                         });

  //                         if (context.read<OperationProvider>().images.length +
  //                                 selectedImages.length +
  //                                 operation.supplierMedia!
  //                                     .where((e) => e.isNotEmpty)
  //                                     .length >
  //                             2) {
  //                           Navigator.pop(context);
  //                           await Alerts.errorAlert(context,
  //                               title: 'Attenzione', subtitle: 'Max 2 foto');
  //                           return;
  //                         }
  //                         if (selectedImages.isNotEmpty) {
  //                           context
  //                               .read<OperationProvider>()
  //                               .addImages(selectedImages);
  //                         }
  //                         Navigator.pop(context);
  //                       } catch (error) {
  //                         print('ERROR_pickImage: $error');
  //                       }
  //                     }),
  //                 ListTile(
  //                   title: const Text('Camera'),
  //                   onTap: () async {
  //                     try {
  //                       XFile? selectedImages = await picker
  //                           .pickImage(
  //                         source: ImageSource.camera,
  //                         maxHeight: AppConst.imagePickerHeight,
  //                         maxWidth: AppConst.imagePickerWidth,
  //                         imageQuality: AppConst.imagePickerQuality,
  //                         requestFullMetadata: false,
  //                       )
  //                           .catchError((error) {
  //                         throw error;
  //                       });

  //                       if (selectedImages != null) {
  //                         context
  //                             .read<OperationProvider>()
  //                             .addImage(selectedImages);
  //                         Navigator.pop(context);
  //                       }
  //                     } catch (error) {
  //                       print('ERROR_pickImage: $error');
  //                     }
  //                   },
  //                 ),
  //                 ListTile(
  //                   title: Text('Annulla',
  //                       style: TextStyle(color: AppColors.errorColor)),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             ),
  //           )
  //         : showCupertinoModalPopup(
  //             context: context,
  //             useRootNavigator: true,
  //             builder: (BuildContext context) => CupertinoActionSheet(
  //               title: const Text('Seleziona un opzione'),
  //               actions: <CupertinoActionSheetAction>[
  //                 CupertinoActionSheetAction(
  //                   child: Text(
  //                     'Galleria',
  //                     style: TextStyle(
  //                         fontSize: 17, color: AppColors.labelDarkColor),
  //                   ),
  //                   onPressed: () async {
  //                     try {
  //                       List<XFile>? selectedImages = await picker
  //                           .pickMultiImage(
  //                         maxHeight: AppConst.imagePickerHeight,
  //                         maxWidth: AppConst.imagePickerWidth,
  //                         imageQuality: AppConst.imagePickerQuality,
  //                         requestFullMetadata: false,
  //                       )
  //                           .catchError((error) {
  //                         throw error;
  //                       });

  //                       if (context.read<OperationProvider>().images.length +
  //                               selectedImages.length +
  //                               operation.supplierMedia!
  //                                   .where((e) => e.isNotEmpty)
  //                                   .length >
  //                           2) {
  //                         Navigator.pop(context);
  //                         await Alerts.errorAlert(context,
  //                             title: 'Attenzione', subtitle: 'Max 2 foto');
  //                         return;
  //                       }
  //                       if (selectedImages.isNotEmpty) {
  //                         context
  //                             .read<OperationProvider>()
  //                             .addImages(selectedImages);
  //                       }
  //                       Navigator.pop(context);
  //                     } catch (error) {
  //                       print('ERROR_pickImage: $error');
  //                     }
  //                   },
  //                 ),
  //                 CupertinoActionSheetAction(
  //                   child: Text(
  //                     'Camera',
  //                     style: TextStyle(
  //                         fontSize: 17, color: AppColors.labelDarkColor),
  //                   ),
  //                   onPressed: () async {
  //                     try {
  //                       XFile? selectedImages = await picker
  //                           .pickImage(
  //                         source: ImageSource.camera,
  //                         maxHeight: AppConst.imagePickerHeight,
  //                         maxWidth: AppConst.imagePickerWidth,
  //                         imageQuality: AppConst.imagePickerQuality,
  //                         requestFullMetadata: false,
  //                       )
  //                           .catchError((error) {
  //                         throw error;
  //                       });

  //                       if (selectedImages != null) {
  //                         context
  //                             .read<OperationProvider>()
  //                             .addImage(selectedImages);
  //                         Navigator.pop(context);
  //                       }
  //                     } catch (error) {
  //                       print('ERROR_pickImage: $error');
  //                     }
  //                   },
  //                 ),
  //               ],
  //               cancelButton: CupertinoActionSheetAction(
  //                 isDestructiveAction: true,
  //                 child: Text(
  //                   'Annulla',
  //                   style: TextStyle(fontSize: 17, color: AppColors.errorColor),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ),
  //           );
}
