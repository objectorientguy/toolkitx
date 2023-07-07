import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import 'incident_contractor_list.dart';

class IncidentContractorListTile extends StatelessWidget {
  final Map addIncidentMap;
  static String contractorName = '';

  const IncidentContractorListTile({
    Key? key,
    required this.addIncidentMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("map data=====>${addIncidentMap['companyid']}");
    context.read<ReportNewIncidentBloc>().add(
        ReportNewIncidentContractorListChange(
            selectContractorName: contractorName,
            selectContractorId: (addIncidentMap['companyid'] == null)
                ? ''
                : addIncidentMap['companyid']));
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentContractorSelected,
        builder: (context, state) {
          if (state is ReportNewIncidentContractorSelected) {
            addIncidentMap['companyid'] = state.selectContractorId;
            return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IncidentContractorList(
                              fetchIncidentMasterModel:
                              state.fetchIncidentMasterModel,
                              selectContractorId: state.selectContractorId,
                              selectContractorName:
                              state.selectContractorName)));
                },
                title: Text(DatabaseUtil.getText('contractor'),
                    style: Theme.of(context)
                        .textTheme
                        .medium
                        .copyWith(color: AppColor.black)),
                subtitle: (state.selectContractorName == '')
                    ? null
                    : Padding(
                  padding: const EdgeInsets.only(top: tiniestSpacing),
                  child: Text(state.selectContractorName,
                      style: Theme.of(context)
                          .textTheme
                          .xSmall
                          .copyWith(color: AppColor.black)),
                ),
                trailing:
                const Icon(Icons.navigate_next_rounded, size: kIconSize));
          } else {
            return const SizedBox();
          }
        });
  }
}
