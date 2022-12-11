import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/plugins/dropdown_button/dropdown_button2.dart';
import 'package:adminpanel/screens/operation/utils/utils.dart';
import 'package:flutter/material.dart';

class OperationFields extends StatefulWidget {
  final TextEditingController palaceController;
  final TextEditingController tenantController;
  final TextEditingController descriptionController;

  const OperationFields({
    super.key,
    required this.palaceController,
    required this.tenantController,
    required this.descriptionController,
  });

  @override
  State<OperationFields> createState() => OperationFieldsState();
}

class OperationFieldsState extends State<OperationFields> {
  final FocusNode palaceFocusNode = FocusNode();
  final FocusNode operationTypeFocusNode = FocusNode();
  final FocusNode operationFocusNode = FocusNode();
  final FocusNode tenantFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  bool isPalaceIconVisible = false;
  bool isTenantIconVisible = false;
  bool isDescriptionIconVisible = false;

  String? operationType;
  String? operation;

  @override
  void dispose() {
    widget.palaceController.dispose();
    widget.tenantController.dispose();
    widget.descriptionController.dispose();

    palaceFocusNode.dispose();
    operationTypeFocusNode.dispose();
    operationFocusNode.dispose();
    tenantFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        palaceField(),
        const SizedBox(height: AppConst.padding),
        tenantField(),
        const SizedBox(height: AppConst.padding),
        operationTypeField(context),
        const SizedBox(height: AppConst.padding),
        operationField(context),
        const SizedBox(height: AppConst.padding),
        descriptionField(),
      ],
    );
  }

  TextFormField palaceField() {
    return TextFormField(
      controller: widget.palaceController,
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
                    widget.palaceController.clear();
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
    );
  }

  TextFormField tenantField() {
    return TextFormField(
      controller: widget.tenantController,
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
                    widget.tenantController.clear();
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
    );
  }

  DropdownButtonFormField2 operationTypeField(BuildContext context) {
    return DropdownButtonFormField2(
      focusNode: operationTypeFocusNode,
      buttonSplashColor: AppColors.transparentColor,
      buttonHighlightColor: AppColors.transparentColor,
      isExpanded: true,
      dropdownElevation: 9,
      itemSplashColor: AppColors.tertiaryColor,
      itemHighlightColor: AppColors.tertiaryColor,
      focusColor: AppColors.tertiaryColor,
      selectedItemHighlightColor: AppColors.tertiaryColor,
      icon: Icon(
        Icons.arrow_drop_down_outlined,
        color: AppColors.secondaryColor,
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
      ),
      items: operationTypeList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      onChanged: (value) {},
      onSaved: (value) {
        operationType = value.toString();
      },
      dropdownPadding: EdgeInsets.zero,
      itemPadding: EdgeInsets.zero,
      buttonHeight: 60,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
    );
  }

  DropdownButtonFormField2 operationField(BuildContext context) {
    return DropdownButtonFormField2(
      focusNode: operationFocusNode,
      buttonSplashColor: AppColors.transparentColor,
      buttonHighlightColor: AppColors.transparentColor,
      isExpanded: true,
      dropdownElevation: 9,
      itemSplashColor: AppColors.tertiaryColor,
      itemHighlightColor: AppColors.tertiaryColor,
      focusColor: AppColors.tertiaryColor,
      selectedItemHighlightColor: AppColors.tertiaryColor,
      icon: Icon(
        Icons.arrow_drop_down_outlined,
        color: AppColors.secondaryColor,
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
      ),
      items: operationList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      onChanged: (value) {},
      onSaved: (value) {
        operation = value.toString();
      },
      dropdownPadding: EdgeInsets.zero,
      itemPadding: EdgeInsets.zero,
      buttonHeight: 60,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
    );
  }

  TextFormField descriptionField() {
    return TextFormField(
      controller: widget.descriptionController,
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
                    widget.descriptionController.clear();
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
    );
  }
}
