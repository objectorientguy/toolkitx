import 'package:flutter/material.dart';

import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';

class DateTimeRow extends StatelessWidget {
  const DateTimeRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/calendar.png',
                height: kImageHeight, width: kImageWidth),
            const SizedBox(width: xxTiniestSpacing),
            const Text('24.05.2023 - 30.05.2023 ')
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/clock.png',
                height: kImageHeight, width: kImageWidth),
            const SizedBox(width: xxTiniestSpacing),
            const Text('03:30 - 03:39')
          ],
        ),
      ],
    );
  }
}
