import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';

class PermitAdditionalInfo extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitAdditionalInfo({Key? key, required this.permitDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('AdditionalInformation'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('MethodStatement'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.methodStatement!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('RelevantInfo'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.generalMessage,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('SpecialWork'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.specialWork!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tiny),
        Text(
          'Specific PPR',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.specialppe!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('Protectivemeasures'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.protectivemeasures!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: tiny),
        Text(
          DatabaseUtil.getText('Layout'),
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: xxTinierSpacing),
        Text(permitDetailsModel.data!.tab2!.layout!,
            style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
