import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:flutter/material.dart';

class Operation extends StatefulWidget {
  const Operation({super.key});

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController surnameController =
      TextEditingController(text: '');
  final TextEditingController addressController =
      TextEditingController(text: '');
  final TextEditingController cityontroller = TextEditingController(text: '');
  final TextEditingController capController = TextEditingController(text: '');

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnameFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode capFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(AppConst.padding),
          children: [
            TextFormField(
              controller: nameController,
              focusNode: nameFocusNode,
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
                  onTap: () => nameController.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
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
              controller: surnameController,
              focusNode: surnameFocusNode,
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
                  onTap: () => surnameController.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
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
              controller: addressController,
              focusNode: addressFocusNode,
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
                  onTap: () => addressController.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
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
              controller: cityontroller,
              focusNode: cityFocusNode,
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
                  onTap: () => cityontroller.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
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
              controller: capController,
              focusNode: capFocusNode,
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
                  onTap: () => capController.clear(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor),
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
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(AppConst.padding),
          child: Button(
            text: 'Invia richiesta',
            onPressed: () => send(context),
          ),
        ),
      ),
    );
  }
}

Future<void> send(BuildContext context) async {
  hideKeyboard(context);
}
