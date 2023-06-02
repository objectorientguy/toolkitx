import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import 'date_time.dart';

class PermitDetails extends StatelessWidget {
  const PermitDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: xxTinySpacing),
        Text(
          'Schedule',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        const DateTimeRow(),
        const SizedBox(height: xxTinySpacing),
        Text(
          'NPI',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Tim Service', style: Theme.of(context).textTheme.small),
        const SizedBox(height: xxTinySpacing),
        Text(
          'NPW',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Tobias Drew', style: Theme.of(context).textTheme.small),
        const SizedBox(height: xxTinySpacing),
        Text(
          'Description',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Putting / adding work description here.',
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: xxTinySpacing),
        Text(
          'Location',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('Tim Service', style: Theme.of(context).textTheme.small),
        const SizedBox(height: xxTinySpacing),
        Text(
          'Company',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text('ToolkitX Test Workforce',
            style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
