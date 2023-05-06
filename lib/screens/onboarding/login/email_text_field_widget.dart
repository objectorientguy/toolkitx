import 'package:flutter/material.dart';
import '../../../configs/app_color.dart';

class EmailTextFieldWidget extends StatelessWidget {
  final int? maxLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? emailController;
  const EmailTextFieldWidget(
      {Key? key,
      this.maxLines,
      this.textInputAction,
      this.maxLength,
      this.textInputType,
      this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: double.infinity,
      child: TextField(
        controller: emailController,
        onChanged: (value) {},
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        cursorColor: AppColor.black,
        decoration: const InputDecoration(
            counterText: "",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.grey),
            ),
            filled: true,
            fillColor: AppColor.white),
      ),
    );
  }
}
