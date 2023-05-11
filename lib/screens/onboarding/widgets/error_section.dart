import 'package:flutter/material.dart';

class ErrorSection extends StatelessWidget {
  const ErrorSection(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);
  final void Function() onPressed;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          minimumSize: MaterialStatePropertyAll(Size(
              MediaQuery.of(context).size.width * 0.12,
              MediaQuery.of(context).size.width * 0.1))),
      child: Text(textValue),
    );
  }
}
