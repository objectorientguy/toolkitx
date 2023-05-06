import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final ButtonStyle? style;
  final Widget? child;

  const LoginButton({Key? key, this.onPressed, this.style, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.23,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
