import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderProvider, child) {
        Future.delayed(const Duration(seconds: 2), () {
          loaderProvider.setShowLabel(true);
        });

        return loaderProvider.showLabel == false
            ? Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Center(
                child: Text(
                  'Nessun elemento trovato',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                  ),
                ),
              );
      },
    );
  }
}
