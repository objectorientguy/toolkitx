import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function() onPressed;

  const CustomOutlinedButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, size: kIconSize),
      label: const Text(StringConstants.kUpload),
    );
  }
}
