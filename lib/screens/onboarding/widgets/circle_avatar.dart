import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../../../configs/app_color.dart';

class CircleAvatarWidget extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  final Widget? child;
  final double? radius;

  const CircleAvatarWidget(
      {Key? key, this.backgroundImage, this.child, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppColor.blueGrey,
        backgroundImage: backgroundImage,
        radius: kCircleAvatarRadius,
        child: child);
  }
}
