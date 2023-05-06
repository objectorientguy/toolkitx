import 'package:flutter/material.dart';

import '../../../configs/app_color.dart';

class TextFieldWidget extends StatelessWidget {
  final int? maxLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? textFieldController;
  final String? getText;

  const TextFieldWidget(
      {Key? key,
      this.maxLines,
      this.textInputAction,
      this.maxLength,
      this.textInputType,
      this.textFieldController,
        this.getText
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: double.infinity,
      child: TextField(
        controller: textFieldController,
        onChanged: (value) {},
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGrey),
            ),
            filled: true,
            fillColor: AppColor.white),
      ),
    );
  }
}
