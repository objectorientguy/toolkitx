import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String textValue;

  const LoginButton(
      {Key? key, required this.onPressed, required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.23,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(textValue),
      ),
    );
  }
}
