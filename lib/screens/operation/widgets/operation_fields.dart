import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/plugins/dropdown_button/dropdown_button2.dart';
import 'package:adminpanel/screens/operation/utils/load_user.dart';
import 'package:adminpanel/screens/operation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OperationFields extends StatefulWidget {
  final TextEditingController palaceController;
  final TextEditingController tenantController;
  final TextEditingController operationTypeController;
  final TextEditingController operationController;
  final TextEditingController descriptionController;

  const OperationFields({
    super.key,
    required this.palaceController,
    required this.tenantController,
    required this.operationTypeController,
    required this.operationController,
    required this.descriptionController,
  });

  @override
  State<OperationFields> createState() => OperationFieldsState();
}

class OperationFieldsState extends State<OperationFields> {
  final FocusNode operationTypeFocusNode = FocusNode();
  final FocusNode operationFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  bool isDescriptionIconVisible = false;

  @override
  void initState() {
    super.initState();
    loadUser(context, widget.palaceController, widget.tenantController);
  }

  @override
  void dispose() {
    widget.palaceController.dispose();
    widget.tenantController.dispose();
    widget.descriptionController.dispose();

    operationTypeFocusNode.dispose();
    operationFocusNode.dispose();
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
      readOnly: true,
      controller: widget.palaceController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Condominio',
        hintStyle: TextStyle(color: AppColors.secondaryColor),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.secondaryColor),
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
      readOnly: true,
      controller: widget.tenantController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Inquilino',
        hintStyle: TextStyle(color: AppColors.secondaryColor),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.secondaryColor),
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
      itemSplashColor: AppColors.transparentColor,
      itemHighlightColor: AppColors.transparentColor,
      focusColor: AppColors.transparentColor,
      selectedItemHighlightColor: AppColors.tertiaryColor,
      icon: Icon(
        Icons.arrow_drop_down_rounded,
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
      onChanged: (value) {
        widget.operationTypeController.text = value.toString();
      },
      validator: (value) {
        if (value == null) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      onSaved: (value) {
        widget.operationTypeController.text = value.toString();
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
      itemSplashColor: AppColors.transparentColor,
      itemHighlightColor: AppColors.transparentColor,
      focusColor: AppColors.transparentColor,
      selectedItemHighlightColor: AppColors.tertiaryColor,
      icon: Icon(
        Icons.arrow_drop_down_rounded,
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
      onChanged: (value) {
        widget.operationController.text = value.toString();
      },
      validator: (value) {
        if (value == null) {
          return 'Il campo non può essere vuoto';
        }
        return null;
      },
      onSaved: (value) {
        widget.operationController.text = value.toString();
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
      textInputAction: TextInputAction.done,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 1000,
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
                  Icons.cancel_rounded,
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
