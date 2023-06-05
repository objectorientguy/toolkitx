import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../incident/widgets/date_picker.dart';

class PermitFilterScreen extends StatelessWidget {
  static const routeName = 'PermitFilterScreen';

  const PermitFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kFilter,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(StringConstants.kDateRange,
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxTinySpacing),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: DatePickerTextField(
                    hintText: StringConstants.kSelectDate,
                  ),
                ),
                const SizedBox(width: xxTinierSpacing),
                const Text(StringConstants.kBis),
                const SizedBox(width: xxTinierSpacing),
                Expanded(
                  child: DatePickerTextField(
                    hintText: StringConstants.kSelectDate,
                  ),
                )
              ]),
              const SizedBox(height: xxTinySpacing),
              Text(StringConstants.kPermitType,
                  style: Theme.of(context)
                      .textTheme
                      .xSmall
                      .copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: xxxTinierSpacing),
              Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    backgroundColor: AppColor.lightestGrey,
                    label: Text('Authorisation to work',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  FilterChip(
                    label: Text('Crew transfer vessel',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  FilterChip(
                    label: Text('E- Authorisation to work',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  FilterChip(
                    label: Text('Hoist operation',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  FilterChip(
                    label: Text('Home',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  FilterChip(
                    label: Text('Material to OSS',
                        style: Theme.of(context).textTheme.xxSmall.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal)),
                    onSelected: (bool selected) {
                      // Handle chip selection
                    },
                  ),
                  // Add more filter chips as needed
                ],
              ),
              const SizedBox(height: xxxSmallerSpacing),
              PrimaryButton(onPressed: () {}, textValue: StringConstants.kApply)
            ],
          ),
        ),
      ),
    );
  }
}
