import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import '../configs/app_color.dart';

class CircleAvatarWidget extends StatelessWidget {
  final double? radius;
  final String imagePath;
  final String path = 'assets/icons/';

  const CircleAvatarWidget({Key? key, this.radius, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: kElevation,
        borderRadius: BorderRadius.circular(kCircleAvatarRadius),
        child: CircleAvatar(
            backgroundColor: AppColor.blueGrey,
            radius: kCircleAvatarRadius,
            child: Image.asset('$path$imagePath',
                height: kCircleAvatarImgHeight, width: kCircleAvatarImgWidth)));
  }
}
