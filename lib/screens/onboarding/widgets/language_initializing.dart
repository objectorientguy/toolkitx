import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_dimensions.dart';

class LanguageInitializing {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Container(
                height: kLanguagePopUpHeight,
                width: kLanguagePopUpWidth,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(kCardRadius)),
                child: Center(
                    child: Text(
                  "Initializing Language...",
                  style: Theme.of(context).textTheme.medium,
                ))));
      },
    );
  }

  static Widget showLoadingWidget(BuildContext context) {
    return Center(
        child: Container(
            color: AppColor.white,
            child: const Text("Initializing Language...")));
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
