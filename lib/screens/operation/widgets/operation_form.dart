import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:flutter/material.dart';

class OperationForm extends StatelessWidget {
  OperationForm({Key? key}) : super(key: key);

  final TextEditingController palaceController =
      TextEditingController(text: '');
  final TextEditingController tenantController =
      TextEditingController(text: '');
  final TextEditingController operationTypeController =
      TextEditingController(text: '');
  final TextEditingController operation = TextEditingController(text: '');
  final TextEditingController descriptionController =
      TextEditingController(text: '');

  final FocusNode palaceFocusNode = FocusNode();
  final FocusNode tenantFocusNode = FocusNode();
  final FocusNode operationTypeFocusNode = FocusNode();
  final FocusNode operationFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppConst.padding),
      children: [
        TextFormField(
          controller: palaceController,
          focusNode: palaceFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Nome',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffix: GestureDetector(
              child: const Icon(Icons.clear, size: 20),
              onTap: () => palaceController.clear(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: AppConst.padding),
        TextFormField(
          controller: tenantController,
          focusNode: tenantFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Cognome',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffix: GestureDetector(
              child: const Icon(Icons.clear, size: 20),
              onTap: () => tenantController.clear(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: AppConst.padding),
        TextFormField(
          controller: operationTypeController,
          focusNode: operationTypeFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Indirizzo',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffix: GestureDetector(
              child: const Icon(Icons.clear, size: 20),
              onTap: () => operationTypeController.clear(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: AppConst.padding),
        TextFormField(
          controller: operation,
          focusNode: operationFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Città',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffix: GestureDetector(
              child: const Icon(Icons.clear, size: 20),
              onTap: () => operation.clear(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: AppConst.padding),
        TextFormField(
          controller: descriptionController,
          focusNode: descriptionFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'C.A.P.',
            labelStyle: TextStyle(color: AppColors.secondaryColor),
            alignLabelWithHint: true,
            suffix: GestureDetector(
              child: const Icon(Icons.clear, size: 20),
              onTap: () => descriptionController.clear(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColors.errorColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
