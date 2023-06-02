import 'package:flutter/material.dart';
import '../utils/database_utils.dart';

class DatabaseText extends StatelessWidget {
  final String textValue;
  final TextStyle? textStyle;
  final int? maxLine;
  final TextAlign? textAlign;

  const DatabaseText(
      {Key? key,
      this.textValue = '',
      this.textStyle,
      this.maxLine,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        (DatabaseUtil.box.get(textValue) == null)
            ? ''
            : DatabaseUtil.box.get(textValue),
        style: textStyle,
        maxLines: maxLine,
        textAlign: textAlign);
  }
}
