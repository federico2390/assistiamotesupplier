import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool margin;
  final double size;
  final double? value;

  const LoadingIndicator({
    Key? key,
    this.margin = true,
    this.size = 20.0,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin == true ? const EdgeInsets.all(20) : EdgeInsets.zero,
        width: size,
        height: size,
        child: !Platform.isAndroid
            ? CircularProgressIndicator(
                value: value, color: AppColors.primaryColor, strokeWidth: 3)
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
