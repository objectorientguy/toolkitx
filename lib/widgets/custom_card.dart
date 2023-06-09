import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final Widget? child;

  const CustomCard(
      {Key? key,
      this.color,
      this.elevation,
      this.shape,
      this.margin,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        elevation: elevation,
        shape: shape,
        margin: margin,
        child: child);
  }
}
