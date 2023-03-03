import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/globals/button.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:adminpanel/providers/search.dart';
import 'package:adminpanel/utils/hide_keyboard.dart';

class SearchBar extends StatefulWidget {
  final double width;
  final String? placeholder;

  const SearchBar({Key? key, required this.width, required this.placeholder})
      : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: widget.width,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7,
        margin: EdgeInsets.zero,
        shadowColor: AppColors.secondaryColor.withOpacity(.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConst.borderRadius),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 58),
              alignment: Alignment.center,
              width: widget.width,
              child: TextField(
                controller: context.read<SearchProvider>().searchController,
                textInputAction: TextInputAction.search,
                onEditingComplete: () {
                  hideKeyboard(context);
                },
                onChanged: (value) {
                  context.read<SearchProvider>().setSearchText(value);

                  if (value.isNotEmpty) {
                    Future.delayed(const Duration(seconds: 2), () {
                      context.read<LoaderProvider>().setShowLabel(true);
                    });
                  } else {
                    context.read<LoaderProvider>().setShowLabel(false);
                  }
                },
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 5),
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: widget.placeholder,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Button(
                color: AppColors.backgroundColor,
                icon: Icon(
                  Icons.search,
                  color: AppColors.errorColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
