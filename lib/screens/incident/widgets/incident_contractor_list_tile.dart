import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import 'incident_contractor_list.dart';

class IncidentContractorListTile extends StatelessWidget {
  final List<List<IncidentMasterDatum>> incidentMasterDatum;
  final int selectContractorId;
  final String selectContractorName;
  final String reportAnonymous;

  const IncidentContractorListTile(
      {Key? key,
      required this.incidentMasterDatum,
      required this.selectContractorId,
      required this.selectContractorName,
      required this.reportAnonymous})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IncidentContractorList(
                      incidentMasterDatum: incidentMasterDatum,
                      selectContractorId: selectContractorId,
                      selectContractorName: selectContractorName,
                      reportAnonymous: reportAnonymous)));
        },
        title: Text(DatabaseUtil.getText('contractor'),
            style: Theme.of(context)
                .textTheme
                .medium
                .copyWith(color: AppColor.black)),
        subtitle: (selectContractorName == '')
            ? null
            : Text(selectContractorName,
                style: Theme.of(context)
                    .textTheme
                    .xSmall
                    .copyWith(color: AppColor.black)),
        trailing: const Icon(Icons.navigate_next_rounded, size: kIconSize));
  }
}
