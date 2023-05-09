import 'package:flutter/material.dart';

class EmailButton extends StatelessWidget {
  final void Function() onPressed;
  final String textValue;

  const EmailButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(textValue),
    );
  }
}
