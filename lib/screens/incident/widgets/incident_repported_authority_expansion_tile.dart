import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_text_field.dart';
import 'date_picker.dart';

class IncidentReportedAuthorityExpansionTile extends StatelessWidget {
  final Map addIncidentMap;

  const IncidentReportedAuthorityExpansionTile(
      {Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(
        ReportNewIncidentAuthorityExpansionChange(
            reportIncidentAuthorityId: ''));
    String authorityName = '';
    String reportedDate = '';
    return BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ReportNewIncidentAuthoritySelected,
        builder: (context, state) {
          if (state is ReportNewIncidentAuthoritySelected) {
            return Column(children: [
              Theme(
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
                          authorityName == ''
                              ? DatabaseUtil.getText('No')
                              : authorityName,
                          style: Theme.of(context).textTheme.xSmall),
                      children: [
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.reportIncidentAuthorityMap.keys.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: xxxTinierSpacing),
                                  activeColor: AppColor.deepBlue,
                                  title: Text(
                                      state.reportIncidentAuthorityMap.values
                                          .elementAt(index),
                                      style:
                                          Theme.of(context).textTheme.xSmall),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  value: state.reportIncidentAuthorityMap.keys
                                      .elementAt(index),
                                  groupValue: state.reportIncidentAuthorityId,
                                  onChanged: (value) {
                                    value = state
                                        .reportIncidentAuthorityMap.keys
                                        .elementAt(index);
                                    authorityName = state
                                        .reportIncidentAuthorityMap.values
                                        .elementAt(index);
                                    context.read<ReportNewIncidentBloc>().add(
                                        ReportNewIncidentAuthorityExpansionChange(
                                            reportIncidentAuthorityId: value));
                                  });
                            })
                      ])),
              Visibility(
                  visible: state.reportIncidentAuthorityId == '1',
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: tinySpacing),
                        Text(DatabaseUtil.getText('WhichAuthority'),
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        TextFieldWidget(
                            hintText: DatabaseUtil.getText('WhichAuthority'),
                            onTextFieldChanged: (String textField) {
                              addIncidentMap['responsible_person'] = textField;
                            }),
                        const SizedBox(height: tinySpacing),
                        Text(DatabaseUtil.getText('WhenReported'),
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        DatePickerTextField(
                          hintText: StringConstants.kSelectDate,
                          onDateChanged: (String date) {
                            reportedDate = date;
                          },
                        ),
                        const SizedBox(height: tinySpacing),
                        Text(StringConstants.kTime,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        TimePickerTextField(
                          hintText: StringConstants.kSelectTime,
                          onTimeChanged: (String time) {
                            addIncidentMap['reporteddatetime'] =
                                '$reportedDate $time';
                          },
                        ),
                        const SizedBox(height: tinySpacing)
                      ]))
            ]);
          } else {
            return const SizedBox();
          }
        });
  }
}
