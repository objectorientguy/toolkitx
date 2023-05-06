import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color? color;
  final Color? shadowColor;
  final double? elevation;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Widget? child;

  const CardWidget(
      {Key? key,
      this.color,
      this.shadowColor,
      this.elevation,
      this.shape,
      this.margin,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        shadowColor: shadowColor,
        elevation: elevation,
        shape: shape,
        margin: margin,
        child: child);
  }
}
