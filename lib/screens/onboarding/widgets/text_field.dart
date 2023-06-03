import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

typedef TextFieldCallBack = Function(String textValue);

class TextFieldWidget extends StatelessWidget {
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController textFieldController = TextEditingController();
  final String value;
  final String? hintText;
  final TextFieldCallBack? onTextFieldValueChanged;
  final String? suffixText;

  TextFieldWidget(
      {Key? key,
      this.textInputAction,
      this.maxLength,
      this.textInputType,
      this.value = '',
      this.hintText,
      this.maxLines = 1,
      this.onTextFieldValueChanged,
      this.suffixText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textFieldController.text = value;
    return TextField(
        controller: textFieldController,
        onChanged: (value) {
          onTextFieldValueChanged!(value);
        },
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        decoration: InputDecoration(
            suffixText: suffixText,
            hintStyle: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(midTiniestSpacing),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGrey),
            ),
            filled: true,
            fillColor: AppColor.white));
  }
}
