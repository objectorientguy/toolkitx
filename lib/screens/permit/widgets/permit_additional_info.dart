import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';

class PermitAdditionalInfo extends StatelessWidget {
  const PermitAdditionalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: tinySpacing),
        Text(
          'Additional Information',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        const SizedBox(height: tinySpacing),
        Text(
          'Method Statement',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Add method statement here',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tinySpacing),
        Text(
          'Relevant Info',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Tobias Drew', style: Theme.of(context).textTheme.small),
        const SizedBox(height: tinySpacing),
        Text(
          'Special Work',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Putting / adding work description here.',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tinySpacing),
        Text(
          'Specific PPR',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Protective glasses, boots, caps',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tinySpacing),
        Text(
          'Protective Measures',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Extra lights, Fire extinguisher, Fire prevention',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tinySpacing),
        Text(
          'Layout',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Layout first', style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
