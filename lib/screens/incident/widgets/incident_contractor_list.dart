import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../data/models/incident/fetch_incident_master_model.dart';
import '../../../widgets/generic_app_bar.dart';

class IncidentContractorList extends StatelessWidget {
  final List<List<IncidentMasterDatum>> incidentMasterDatum;
  final int selectContractorId;
  final String selectContractorName;

  const IncidentContractorList(
      {Key? key,
      required this.incidentMasterDatum,
      required this.selectContractorId,
      required this.selectContractorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(title: 'Select Contractor'),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(top: topBottomPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: xxTiniestSpacing),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding:
                            const EdgeInsets.only(bottom: xxTiniestSpacing),
                        shrinkWrap: true,
                        itemCount: incidentMasterDatum[8].length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: xxxMediumSpacing,
                              child: RadioListTile(
                                  activeColor: AppColor.deepBlue,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  title: Text(incidentMasterDatum[8][index]
                                      .groupName
                                      .toString()),
                                  value: incidentMasterDatum[8][index].groupId,
                                  groupValue: selectContractorId,
                                  onChanged: (value) {
                                    value =
                                        incidentMasterDatum[8][index].groupId;
                                    context.read<ReportNewIncidentBloc>().add(
                                        ReportIncidentExpansionChange(
                                            reportAnonymously: '',
                                            selectContractorId: value!,
                                            selectContractorName:
                                                incidentMasterDatum[8][index]
                                                    .groupName!));
                                    Navigator.pop(context);
                                  }));
                        }),
                    const SizedBox(height: xxxSmallerSpacing)
                  ])),
        ));
  }
}
