import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  // This file will get removed after merging dev.
  final void Function() onPressed;
  final String label;

  const CustomOutlinedButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add, size: kIconSize),
        label: Text(label));
  }
}
