import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/repository/user.dart';
import 'package:adminpanel/screens/operation/utils/utils.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/picker_action_sheet.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperationForm extends StatefulWidget {
  const OperationForm({super.key});

  @override
  State<OperationForm> createState() => OperationFormState();
}

class OperationFormState extends State<OperationForm> {
  final TextEditingController palaceController = TextEditingController();
  final TextEditingController tenantController = TextEditingController();
  final TextEditingController operationTypeController =
      TextEditingController(text: 'Non specificato');
  final TextEditingController operationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FocusNode palaceFocusNode = FocusNode();
  final FocusNode tenantFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  bool isPalaceIconVisible = false;
  bool isTenantIconVisible = false;
  bool isDescriptionIconVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    palaceController.dispose();
    tenantController.dispose();
    operationTypeController.dispose();
    operationController.dispose();
    descriptionController.dispose();

    palaceFocusNode.dispose();
    tenantFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.all(AppConst.padding),
        children: [
          TextFormField(
            controller: palaceController,
            focusNode: palaceFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            toolbarOptions: const ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isPalaceIconVisible = true;
                });
              } else {
                setState(() {
                  isPalaceIconVisible = false;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Condominio',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
              suffixIcon: isPalaceIconVisible == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          palaceController.clear();
                          isPalaceIconVisible = false;
                        });
                      },
                      child: Icon(
                        Icons.cancel,
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
          ),
          const SizedBox(height: AppConst.padding),
          TextFormField(
            controller: tenantController,
            focusNode: tenantFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            toolbarOptions: const ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isTenantIconVisible = true;
                });
              } else {
                setState(() {
                  isTenantIconVisible = false;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Inquilino',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
              suffixIcon: isTenantIconVisible == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          tenantController.clear();
                          isTenantIconVisible = false;
                        });
                      },
                      child: Icon(
                        Icons.cancel,
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
          ),
          const SizedBox(height: AppConst.padding),
          TextFormField(
            readOnly: true,
            controller: operationTypeController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: const Text(
                    'Seleziona la tipologia di intervento',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  data: operationTypeList,
                  selectedItems: (List<dynamic> selectedList) {
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        operationTypeController.text = item.name;
                      }
                    }
                  },
                ),
              ).showModal(context);
            },
            decoration: InputDecoration(
              labelText: 'Seleziona la tipologia di intervento',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              hintStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
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
          ),
          const SizedBox(height: AppConst.padding),
          TextFormField(
            readOnly: true,
            controller: operationController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: const Text(
                    'Seleziona il richiedente',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  data: operationList,
                  selectedItems: (List<dynamic> selectedList) {
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        operationController.text = item.name;
                      }
                    }
                  },
                ),
              ).showModal(context);
            },
            decoration: InputDecoration(
              labelText: 'Seleziona il richiedente',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              hintStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
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
          ),
          const SizedBox(height: AppConst.padding),
          TextFormField(
            controller: descriptionController,
            focusNode: descriptionFocusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            toolbarOptions: const ToolbarOptions(
                copy: true, cut: true, paste: true, selectAll: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Il campo non può essere vuoto';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isDescriptionIconVisible = true;
                });
              } else {
                setState(() {
                  isDescriptionIconVisible = false;
                });
              }
            },
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Descrivi il problema',
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              alignLabelWithHint: true,
              suffixIcon: isDescriptionIconVisible == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          descriptionController.clear();
                          isDescriptionIconVisible = false;
                        });
                      },
                      child: Icon(
                        Icons.cancel,
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
          ),
          const SizedBox(height: AppConst.padding),
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
            children: [null, ...context.watch<OperationProvider>().images].map(
              (image) {
                if (image == null) {
                  return Button(
                    color: AppColors.secondaryColor.withOpacity(.5),
                    icon: const Icon(
                      Icons.add,
                      size: 44,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        buildPickerActionSheet(context, OperationProvider),
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
                              Icons.close,
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
                      style:
                          TextStyle(fontSize: 12, color: AppColors.errorColor),
                    )
                  : const SizedBox()
              : const SizedBox(),
          const SizedBox(height: AppConst.padding * 2),
          Button(
            text: 'Invia richiesta',
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  context.read<OperationProvider>().images.isNotEmpty &&
                  UserRepository().isLogged == true) {
                hideKeyboard(context);
                print(
                  'palaceController: ${palaceController.text}\ntenantController: ${tenantController.text}\noperationTypeController: ${operationTypeController.text}\noperationController: ${operationController.text}\ndescriptionController: ${descriptionController.text}\nimages: ${context.read<OperationProvider>().images.length}',
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
