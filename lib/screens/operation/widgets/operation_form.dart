import 'dart:io';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/screens/operation/widgets/operation_fields.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/image_picker.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperationForm extends StatefulWidget {
  const OperationForm({super.key});

  @override
  State<OperationForm> createState() => OperationFormState();
}

class OperationFormState extends State<OperationForm> {
  final TextEditingController operationTypeController = TextEditingController();
  final TextEditingController operationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(AppConst.padding),
        children: [
          OperationFields(
            operationTypeController: operationTypeController,
            operationController: operationController,
            descriptionController: descriptionController,
          ),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 3),
                children:
                    [null, ...context.watch<OperationProvider>().images].map(
                  (image) {
                    if (image == null) {
                      return Button(
                          color: AppColors.secondaryColor.withOpacity(.5),
                          icon: const Icon(
                            Icons.add_rounded,
                            size: 44,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (context
                                    .read<OperationProvider>()
                                    .images
                                    .length ==
                                3) {
                              Alerts.errorAlert(context,
                                      title: 'Attenzione',
                                      subtitle: 'Max 3 foto')
                                  .whenComplete(() => context
                                      .read<CentralProvider>()
                                      .isLoading(false));
                              return;
                            } else {
                              buildImagePicker(context, OperationProvider);
                            }
                          });
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
                            Navigator.pushNamed(
                              context,
                              '/gallery',
                              arguments: GalleryArguments(
                                context.read<OperationProvider>().images,
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
              ),
              formKey.currentState != null
                  ? formKey.currentState!.validate() == false &&
                          context.read<OperationProvider>().images.isEmpty
                      ? const SizedBox(height: AppConst.padding / 2)
                      : const SizedBox()
                  : const SizedBox(),
              formKey.currentState != null
                  ? formKey.currentState!.validate() == false &&
                          context.read<OperationProvider>().images.isEmpty
                      ? Text(
                          'Aggiungi almeno un allegato',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.errorColor),
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: AppConst.padding * 2),
          Button(
            text: 'Invia richiesta',
            color: operationTypeController.text.isNotEmpty &&
                    operationController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    context.read<OperationProvider>().images.isNotEmpty
                ? null
                : AppColors.secondaryColor,
            onPressed: () async {
              if (formKey.currentState!.validate() &&
                  context.read<OperationProvider>().images.isNotEmpty &&
                  User().isLogged == true) {
                hideKeyboard(context);

                Operation().postOperation(
                  context,
                  formKey,
                  operationTypeController,
                  operationController,
                  descriptionController,
                );
              } else {
                Alerts.errorAlert(context,
                    title: 'Ops!', subtitle: 'Completa tutti i campi');
              }
            },
          ),
        ],
      ),
    );
  }
}
