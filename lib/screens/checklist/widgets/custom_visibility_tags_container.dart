import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class CustomVisibilityTagContainer extends StatelessWidget {
  final bool visible;
  final Color color;
  final String textValue;

  const CustomVisibilityTagContainer(
      {Key? key,
      required this.visible,
      required this.color,
      required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visible,
        child: Container(
            padding: const EdgeInsets.all(tiniestSpacing),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(kCardRadius)),
            height: kTagsHeight,
            child: Text(textValue,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.white))));
  }
}
