import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';

class IncidentReportAnonymousExpansionTile extends StatelessWidget {
  final List anonymousList;
  final String reportAnonymous;
  final int selectContractorId;
  final String selectContractorName;

  const IncidentReportAnonymousExpansionTile(
      {Key? key,
      required this.anonymousList,
      required this.reportAnonymous,
      required this.selectContractorId,
      required this.selectContractorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: kExpansionTileMargin, right: kExpansionTileMargin),
            collapsedBackgroundColor: AppColor.white,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text(reportAnonymous,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: anonymousList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: AppColor.deepBlue,
                        title: Text(anonymousList[index],
                            style: Theme.of(context).textTheme.xSmall),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: anonymousList[index],
                        groupValue: reportAnonymous,
                        onChanged: (value) {
                          value = anonymousList[index];
                          context.read<ReportNewIncidentBloc>().add(
                              ReportIncidentExpansionChange(
                                  reportAnonymously: value,
                                  selectContractorId: selectContractorId,
                                  selectContractorName: selectContractorName));
                        });
                  })
            ]));
  }
}
