import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/incident_details_model.dart';
import '../../../utils/constants/string_constants.dart';

class IncidentCustomFieldInfo extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;
  final int initialIndex;

  const IncidentCustomFieldInfo(
      {Key? key,
      required this.incidentDetailsModel,
      required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (incidentDetailsModel.data!.customfields!.isEmpty)
        ? Center(
            child: Text(StringConstants.kNoCustomFields,
                style: Theme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w700, color: AppColor.mediumBlack)))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: incidentDetailsModel.data!.customfields!.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(incidentDetailsModel.data!.customfields![index].title,
                        style: Theme.of(context).textTheme.medium.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: xxTinierSpacing),
                    Text(
                        incidentDetailsModel
                            .data!.customfields![index].fieldvalue!,
                        style: Theme.of(context).textTheme.small),
                    const SizedBox(height: xxTinierSpacing),
                  ]);
            });
  }
}
