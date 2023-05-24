import 'package:flutter/material.dart';
import '../../../utils/constants/string_constants.dart';
import 'error_section.dart';

class ShowError extends StatelessWidget {
  final void Function() onPressed;

  const ShowError({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ErrorSection(onPressed: onPressed, textValue: StringConstants.kReload)
        ]);
  }
}
