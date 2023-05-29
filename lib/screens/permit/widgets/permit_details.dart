import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';

class PermitDetails extends StatelessWidget {
  const PermitDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: smallSpacing),
        Text(
          'Schedule',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/calendar.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: midTiniestSpacing),
                const Text('24.05.2023 - 30.05.2023 ')
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/clock.png',
                    height: kImageHeight, width: kImageWidth),
                const SizedBox(width: midTiniestSpacing),
                const Text('03:30 - 03:39')
              ],
            ),
          ],
        ),
        const SizedBox(height: smallSpacing),
        Text(
          'NPI',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Tim Service', style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'NPW',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Tobias Drew', style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Description',
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
          'Location',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('Tim Service', style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Company',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text('ToolkitX Test Workforce',
            style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
