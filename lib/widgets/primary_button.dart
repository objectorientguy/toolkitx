import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);
  final void Function() onPressed;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(textValue),
    );
  }
}
