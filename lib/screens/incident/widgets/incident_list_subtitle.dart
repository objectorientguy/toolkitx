import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incidents_list_model.dart';

class IncidentListSubtitle extends StatelessWidget {
  final IncidentListDatum incidentListDatum;

  const IncidentListSubtitle({Key? key, required this.incidentListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(incidentListDatum.description,
          style: Theme.of(context).textTheme.xSmall),
      const SizedBox(height: tiniestSpacing),
      Text(incidentListDatum.location,
          style: Theme.of(context)
              .textTheme
              .xSmall
              .copyWith(color: AppColor.grey)),
      const SizedBox(height: xxTinierSpacing),
      Row(children: [
        Image.asset("assets/icons/calendar.png",
            height: kIconSize, width: kIconSize),
        const SizedBox(width: tiniestSpacing),
        Text(incidentListDatum.eventdatetime,
            style: Theme.of(context)
                .textTheme
                .xSmall
                .copyWith(color: AppColor.grey))
      ])
    ]);
  }
}
