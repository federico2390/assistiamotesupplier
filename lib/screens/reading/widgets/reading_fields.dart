import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:flutter/material.dart';

class ReadingFields extends StatefulWidget {
  final TextEditingController valueController;

  const ReadingFields({super.key, required this.valueController});

  @override
  State<ReadingFields> createState() => ReadingFieldsState();
}

class ReadingFieldsState extends State<ReadingFields> {
  bool isValueIconVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        palaceField(),
      ],
    );
  }

  TextFormField palaceField() {
    return TextFormField(
      controller: widget.valueController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
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
            isValueIconVisible = true;
          });
        } else {
          setState(() {
            isValueIconVisible = false;
          });
        }
      },
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Valore',
        labelStyle: TextStyle(color: AppColors.secondaryColor),
        alignLabelWithHint: true,
        suffixIcon: widget.valueController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.valueController.clear();
                    isValueIconVisible = false;
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
