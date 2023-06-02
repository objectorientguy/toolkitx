import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_spacing.dart';
import '../../../data/models/permit/permit_details_model.dart';

class PermitDetails extends StatelessWidget {
  final PermitDetailsModel permitDetailsModel;

  const PermitDetails({Key? key, required this.permitDetailsModel})
      : super(key: key);

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
        Text(permitDetailsModel.data!.tab1!.schedule!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'NPI',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text(permitDetailsModel.data!.tab1!.pnameNpi!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'NPW',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text(permitDetailsModel.data!.tab1!.pname!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Description',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text(permitDetailsModel.data!.tab1!.details!,
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
        Text(permitDetailsModel.data!.tab1!.location!,
            style: Theme.of(context).textTheme.small),
        const SizedBox(height: smallSpacing),
        Text(
          'Company',
          style: Theme.of(context)
              .textTheme
              .medium
              .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: midTiniestSpacing),
        Text(permitDetailsModel.data!.tab1!.pcompany!,
            style: Theme.of(context).textTheme.small),
      ],
    );
  }
}
