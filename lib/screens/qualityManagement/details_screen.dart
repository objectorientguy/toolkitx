import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class QMDetailsScreen extends StatelessWidget {
  static const routeName = 'QMDetailsScreen';

  const QMDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(StringConstants.kReportedBy),
                SizedBox(
                    width: 250,
                    child: Text('Pandora ITC, Sumit Workforce',
                        overflow: TextOverflow.ellipsis))
              ],
            )
          ],
        ),
      ),
    );
  }
}
