import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/data_util.dart';

class ProfileOptionsBody extends StatelessWidget {
  const ProfileOptionsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: DataUtil.profileOptionsList().length,
          itemBuilder: (context, index) {
            return ListTile(
                dense: true,
                title: Text(
                    DataUtil.profileOptionsList().elementAt(index).title,
                    style: Theme.of(context).textTheme.xSmall));
          }),
      const SizedBox(height: largeSpacing),
      Center(
          child: Text("App version 1.0.9",
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.grey)))
    ]));
  }
}
