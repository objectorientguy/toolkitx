import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../configs/app_color.dart';
import '../configs/app_spacing.dart';

class TextFieldWidget extends StatelessWidget {
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? textFieldController;
  final String? value;
  final String? hintText;

  const TextFieldWidget(
      {Key? key,
      this.textInputAction,
      this.maxLength,
      this.textInputType,
      this.textFieldController,
      this.value,
      this.hintText,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textFieldController,
        onChanged: (value) {},
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        decoration: InputDecoration(
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(xxTinierSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGrey),
            ),
            filled: true,
            fillColor: AppColor.white));
  }
}
