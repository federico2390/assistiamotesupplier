import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/api/reading.dart';
import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/gallery.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/screens/reading/widgets/reading_fields.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/image_picker.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';

class ReadingForm extends StatefulWidget {
  const ReadingForm({super.key});

  @override
  State<ReadingForm> createState() => _ReadingFormState();
}

class _ReadingFormState extends State<ReadingForm> {
  final TextEditingController valueController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    valueController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isIPad = false;

    if (Platform.isIOS) {
      final size = MediaQuery.of(context).size;
      if (size.width > 768) {
        isIPad = true;
      }
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(AppConst.padding),
        children: [
          const Text(
            'Inserisci una lettura',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppConst.padding),
          ReadingFields(valueController: valueController),
          const SizedBox(height: AppConst.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Allegati',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppConst.padding),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: isIPad == true ? 7 : 3),
                children:
                    [null, ...context.watch<ReadingProvider>().images].map(
                  (image) {
                    if (image == null) {
                      return Button(
                        color: AppColors.secondaryColor.withOpacity(.5),
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 44,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (context.read<ReadingProvider>().images.length ==
                              3) {
                            await Alerts.errorAlert(context,
                                title: 'Attenzione', subtitle: 'Max 3 foto');
                            return;
                          } else {
                            buildImagePicker(context, ReadingProvider);
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
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.file(File(image.path),
                                height: 80, fit: BoxFit.cover),
                          ),
                          onTap: () {
                            context.read<GalleryProvider>().currentMediaIndex(
                                context
                                    .read<ReadingProvider>()
                                    .images
                                    .indexOf(image));

                            Navigator.pushNamed(
                              context,
                              '/gallery',
                              arguments: GalleryArguments(
                                context.read<ReadingProvider>().images,
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
                                      .read<ReadingProvider>()
                                      .removeImage(image);
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          ),
          const SizedBox(height: AppConst.padding * 2),
          TapDebouncer(
            onTap: () async {
              if (formKey.currentState!.validate() &&
                  UserApi().isLogged == true) {
                hideKeyboard(context);
                await ReadingApi().addReading(
                  context,
                  valueController,
                );
              } else {
                await Alerts.errorAlert(context,
                    title: 'Ops!', subtitle: 'Completa tutti i campi');
              }
            },
            builder: (BuildContext context, TapDebouncerFunc? onTap) {
              return Button(
                  text: 'Invia lettura',
                  color: valueController.text.isNotEmpty
                      ? null
                      : AppColors.secondaryColor,
                  onPressed: onTap);
            },
          ),
          const SizedBox(height: AppConst.padding * 2),
        ],
      ),
    );
  }
}
