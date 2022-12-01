import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/material.dart';

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  final TextEditingController noteController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(AppConst.padding),
          children: [
            Container(
              height: ScreenSize.width(context) / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConst.borderRadius),
                border: Border.all(width: 1, color: AppColors.secondaryColor),
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.add,
                  color: AppColors.secondaryColor,
                  size: 44,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: AppConst.padding * 2),
            TextFormField(
              controller: noteController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              toolbarOptions: const ToolbarOptions(
                  copy: true, cut: true, paste: true, selectAll: true),
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Note aggiuntive',
                labelStyle: TextStyle(color: AppColors.secondaryColor),
                alignLabelWithHint: true,
                suffix: GestureDetector(
                  child: const Icon(Icons.clear, size: 20),
                  onTap: () => noteController.clear(),
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(AppConst.padding),
          child: Button(
            text: 'Invia lettura',
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
