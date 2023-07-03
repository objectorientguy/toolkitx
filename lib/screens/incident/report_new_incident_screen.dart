import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/incident_contractor_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_report_anonymously_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incident_master_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';

class ReportNewIncidentScreen extends StatelessWidget {
  static const routeName = 'ReportNewIncidentScreen';
  final List<List<IncidentMasterDatum>> incidentMasterDatum;

  const ReportNewIncidentScreen({Key? key, required this.incidentMasterDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportNewIncidentBloc>().add(ReportIncidentExpansionChange(
        reportAnonymously: DatabaseUtil.getText('No'),
        selectContractorId: 0,
        selectContractorName: ''));
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kReportNewIncident,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinySpacing),
          child: BlocBuilder<ReportNewIncidentBloc, ReportNewIncidentStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ReportNewIncidentFetched,
              builder: (context, state) {
                if (state is ReportNewIncidentFetched) {
                  String eventDate = '';
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DatabaseUtil.getText('HideMyIdentity'),
                                style: Theme.of(context)
                                    .textTheme
                                    .medium
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            IncidentReportAnonymousExpansionTile(
                                anonymousList: state.reportAnonymousList,
                                reportAnonymous: state.reportAnonymous),
                            const SizedBox(height: tiniestSpacing),
                            IncidentContractorListTile(
                                incidentMasterDatum: incidentMasterDatum,
                                selectContractorId: state.selectContractorId,
                                selectContractorName:
                                    state.selectContractorName),
                            const SizedBox(height: tiniestSpacing),
                            Text(StringConstants.kDateOfIncident,
                                style: Theme.of(context)
                                    .textTheme
                                    .medium
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            DatePickerTextField(
                              hintText: StringConstants.kSelectDate,
                              onDateChanged: (String date) {
                                eventDate = date;
                              },
                            ),
                            const SizedBox(height: tinySpacing),
                            Text(StringConstants.kTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .medium
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            TimePickerTextField(
                              hintText: StringConstants.kSelectTime,
                              onTimeChanged: (String time) {
                                state.addNewIncidentMap['eventdatetime'] =
                                    '$eventDate $time';
                                log("date time=====>${state.addNewIncidentMap['eventdatetime']}");
                              },
                            ),
                            const SizedBox(height: tinySpacing),
                            Text(StringConstants.kDetailedDescription,
                                style: Theme.of(context)
                                    .textTheme
                                    .medium
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            TextFieldWidget(
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                              onTextFieldChanged: (String textField) {
                                state.addNewIncidentMap['description'] =
                                    textField;
                              },
                            ),
                            const SizedBox(height: tinySpacing),
                            Text(StringConstants.kPhoto,
                                style: Theme.of(context)
                                    .textTheme
                                    .medium
                                    .copyWith(color: AppColor.black)),
                            const SizedBox(height: tiniestSpacing),
                            // Image Picker Will be here after dev merge
                            const SizedBox(height: mediumSpacing),
                            PrimaryButton(
                                onPressed: () {},
                                textValue: StringConstants.kNext)
                          ]));
                } else {
                  return const SizedBox();
                }
              })),
    );
  }
}
