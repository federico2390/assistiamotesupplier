import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/utils/action_sheet.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingForm extends StatefulWidget {
  const ReadingForm({super.key});

  @override
  State<ReadingForm> createState() => _ReadingFormState();
}

class _ReadingFormState extends State<ReadingForm> {
  final TextEditingController valueController = TextEditingController();

  bool isValueIconVisible = false;

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppConst.padding),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Allegati',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppConst.padding),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 3),
              children: [null, ...context.watch<ReadingProvider>().images].map(
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
                          buildActionSheet(context, ReadingProvider),
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
                            '/viewer',
                            arguments: ScreenArguments(
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
                                Icons.close,
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
        SizedBox(height: AppConst.padding * 2),
        TextFormField(
          controller: valueController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          toolbarOptions: const ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
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
            suffixIcon: valueController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        valueController.clear();
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
        SizedBox(height: AppConst.padding * 2),
        Button(
          text: 'Invia lettura',
          onPressed: () {
            hideKeyboard(context);
            print(
              'valueController: ${valueController.text}\nimages: ${context.read<ReadingProvider>().images.length}',
            );
          },
        ),
      ],
    );
  }
}
