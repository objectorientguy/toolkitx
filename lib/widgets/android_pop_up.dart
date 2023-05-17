import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class AndroidPopUp extends StatelessWidget {
  final String titleValue;
  final String contentValue;
  final void Function()? onPressed;

  const AndroidPopUp(
      {Key? key,
      required this.titleValue,
      required this.contentValue,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding:
            const EdgeInsets.only(left: tinySpacing, top: tinySpacing),
        buttonPadding: const EdgeInsets.all(tiniestSpacing),
        contentPadding: const EdgeInsets.all(tinySpacing),
        actionsPadding: const EdgeInsets.only(right: tinySpacing),
        title: Text(titleValue),
        content: Text(contentValue),
        titleTextStyle: Theme.of(context)
            .textTheme
            .large
            .copyWith(fontWeight: FontWeight.w500),
        actions: <Widget>[
          TextButton(
              child: const Text(StringConstants.kNo),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              onPressed: onPressed, child: const Text(StringConstants.kYes))
        ]);
  }
}
