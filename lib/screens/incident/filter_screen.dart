import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import 'widgets/date_picker.dart';
import 'widgets/filter_status_expansion_tile.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = 'FilterScreen';

  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
          title: Text(
        StringConstants.kFilter,
      )),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(StringConstants.kDateRange,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: tinySpacing),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: DatePickerTextField(
                  hintText: StringConstants.kSelectDate,
                  onDatePicked: (String pickDate) {},
                ),
              ),
              const SizedBox(width: midTiniestSpacing),
              const Text(StringConstants.kBis),
              const SizedBox(width: midTiniestSpacing),
              Expanded(
                child: DatePickerTextField(
                  hintText: StringConstants.kSelectDate,
                  onDatePicked: (String pickDate) {},
                ),
              )
            ]),
            const SizedBox(height: tinySpacing),
            Text(StringConstants.kStatus,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: tinySpacing),
            const FilterStatusExpansionTile(),
            const SizedBox(height: mediumSpacing),
            PrimaryButton(onPressed: () {}, textValue: StringConstants.kApply)
          ],
        ),
      ),
    );
  }
}
