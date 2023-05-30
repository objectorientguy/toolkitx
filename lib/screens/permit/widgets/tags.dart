import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';

import '../../../configs/app_spacing.dart';

class Tags extends StatelessWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.errorRed,
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          margin: const EdgeInsets.only(
              right: tiniestSpacing, bottom: tiniestSpacing),
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(tiniestSpacing),
            child: Text(
              'Expired',
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.yellow,
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              right: tiniestSpacing, bottom: tiniestSpacing),
          child: const Padding(
            padding: EdgeInsets.all(tiniestSpacing),
            child: Text(
              'NPI',
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.yellow,
            borderRadius: BorderRadius.circular(kCardRadius),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              right: tiniestSpacing, bottom: tiniestSpacing),
          child: const Padding(
            padding: EdgeInsets.all(tiniestSpacing),
            child: Text(
              'NPW',
              style: TextStyle(color: AppColor.white),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
