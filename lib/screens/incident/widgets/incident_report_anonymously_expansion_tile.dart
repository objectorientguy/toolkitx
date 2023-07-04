import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../../configs/app_color.dart';
import '../../../utils/database_utils.dart';

class IncidentReportAnonymousExpansionTile extends StatelessWidget {
  final Map addIncidentMap;

  const IncidentReportAnonymousExpansionTile(
      {Key? key, required this.addIncidentMap})
      : super(key: key);
  static String anonymousName = '';

  @override
  Widget build(BuildContext context) {
    context
        .read<ReportNewIncidentBloc>()
        .add(ReportIncidentAnonymousExpansionChange(reportAnonymousId: ''));
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is IncidentReportAnonymousSelected,
        builder: (context, state) {
          if (state is IncidentReportAnonymousSelected) {
            addIncidentMap['identity'] = state.reportAnonymousId;
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    tilePadding: const EdgeInsets.only(
                        left: kExpansionTileMargin,
                        right: kExpansionTileMargin),
                    collapsedBackgroundColor: AppColor.white,
                    maintainState: true,
                    iconColor: AppColor.deepBlue,
                    textColor: AppColor.black,
                    key: GlobalKey(),
                    title: Text(
                        (anonymousName == '')
                            ? DatabaseUtil.getText('No')
                            : anonymousName,
                        style: Theme.of(context).textTheme.xSmall),
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.reportAnonymousMap.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                activeColor: AppColor.deepBlue,
                                title: Text(
                                    state.reportAnonymousMap.values
                                        .elementAt(index),
                                    style: Theme.of(context).textTheme.xSmall),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: state.reportAnonymousMap.keys
                                    .elementAt(index),
                                groupValue: state.reportAnonymousId,
                                onChanged: (value) {
                                  value = state.reportAnonymousMap.keys
                                      .elementAt(index);
                                  anonymousName = state
                                      .reportAnonymousMap.values
                                      .elementAt(index);
                                  context.read<ReportNewIncidentBloc>().add(
                                      ReportIncidentAnonymousExpansionChange(
                                          reportAnonymousId: value));
                                });
                          })
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
