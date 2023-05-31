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
        const SizedBox(height: smallSpacing),
        Text(
          'Additional Information',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        const SizedBox(height: smallSpacing),
        Text(
          'Method Statement',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Add method statement here',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Relevant Info',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Tobias Drew', style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Special Work',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Putting / adding work description here.',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Specific PPR',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Protective glasses, boots, caps',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Protective Measures',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Extra lights, Fire extinguisher, Fire prevention',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Layout',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Layout first', style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
