import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../onboarding/widgets/text_field.dart';

class CommentsPopUp extends StatelessWidget {
  final String textValue;

  const CommentsPopUp({Key? key, required this.textValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding:
            const EdgeInsets.only(left: smallSpacing, top: smallSpacing),
        buttonPadding: const EdgeInsets.all(tiniestSpacing),
        contentPadding: const EdgeInsets.only(
            left: tinySpacing, right: tinySpacing, top: tinySpacing, bottom: 0),
        actionsPadding:
            const EdgeInsets.only(right: tinySpacing, bottom: tiniestSpacing),
        title: Text(StringConstants.kComments,
            style: Theme.of(context)
                .textTheme
                .small
                .copyWith(color: AppColor.black)),
        content: const TextFieldWidget(maxLines: 7),
        titleTextStyle: Theme.of(context)
            .textTheme
            .large
            .copyWith(fontWeight: FontWeight.w500),
        actions: [
          TextButton(
              child: const Text(StringConstants.kRemove),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(onPressed: () {}, child: Text(textValue))
        ]);
  }
}
