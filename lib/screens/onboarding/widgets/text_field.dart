import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';

typedef TextFieldCallBack = Function(String textFieldValue);

class TextFieldWidget extends StatelessWidget {
  final int? maxLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? textFieldController;
  final String? value;
  final TextFieldCallBack onTextFieldValueChanged;

  const TextFieldWidget(
      {Key? key,
      this.maxLines,
      this.textInputAction,
      this.maxLength,
      this.textInputType,
      this.textFieldController,
      this.value,
      required this.onTextFieldValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textFieldController,
        onChanged: (value) {
          onTextFieldValueChanged(value);
        },
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(midTiniestSpacing),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGrey),
            ),
            filled: true,
            fillColor: AppColor.white));
  }
}
