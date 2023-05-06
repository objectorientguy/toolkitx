import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  final double? radius;
  final Color? foregroundColor;
  final ImageProvider<Object>? foregroundImage;
  final double? minRadius;
  final double? maxRadius;
  final Widget? child;
  final Color? backgroundColor;
  const CircleAvatarWidget(
      {Key? key,
      this.backgroundImage,
      this.radius,
      this.foregroundColor,
      this.foregroundImage,
      this.maxRadius,
      this.minRadius,
      this.child,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      radius: radius,
      foregroundColor: foregroundColor,
      foregroundImage: foregroundImage,
      minRadius: minRadius,
      maxRadius: maxRadius,
      child: child,
    );
  }
}
