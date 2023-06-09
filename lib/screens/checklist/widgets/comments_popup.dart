import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/text_button.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';

class CommentsPopUp extends StatelessWidget {
  final String textValue;

  const CommentsPopUp({Key? key, required this.textValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.only(left: tiny, top: tiny),
        buttonPadding: const EdgeInsets.all(tiniest),
        contentPadding: const EdgeInsets.only(
            left: xxTinySpacing,
            right: xxTinySpacing,
            top: xxTinySpacing,
            bottom: 0),
        actionsPadding:
            const EdgeInsets.only(right: xxTinySpacing, bottom: tiniest),
        title: Text(StringConstants.kComments,
            style: Theme.of(context)
                .textTheme
                .small
                .copyWith(color: AppColor.black)),
        content: TextFieldWidget(
            maxLines: 7, onTextFieldChanged: (String textField) {}),
        titleTextStyle: Theme.of(context)
            .textTheme
            .large
            .copyWith(fontWeight: FontWeight.w500),
        actions: [
          CustomTextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textValue: StringConstants.kRemove),
          CustomTextButton(onPressed: () {}, textValue: textValue)
        ]);
  }
}
