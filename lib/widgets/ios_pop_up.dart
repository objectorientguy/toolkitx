import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_color.dart';
import '../utils/constants/string_constants.dart';

class IosPopUp extends StatelessWidget {
  final String titleValue;
  final String contentValue;
  final void Function()? onPressed;

  const IosPopUp(
      {Key? key,
      required this.titleValue,
      required this.contentValue,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: const Text(StringConstants.kLogout),
        content: const Text(StringConstants.kLogoutDialogContent),
        actions: [
          CupertinoDialogAction(
            textStyle: Theme.of(context).textTheme.xSmall.copyWith(
                color: AppColor.deepBlue, fontWeight: FontWeight.w500),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(StringConstants.kNo),
          ),
          CupertinoDialogAction(
              textStyle: Theme.of(context).textTheme.xSmall.copyWith(
                  color: AppColor.deepBlue, fontWeight: FontWeight.w500),
              onPressed: onPressed,
              child: const Text(StringConstants.kYes))
        ]);
  }
}
