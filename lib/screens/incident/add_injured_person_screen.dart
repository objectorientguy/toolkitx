import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_floating_action_button.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/text_button.dart';
import 'incident_list_screen.dart';

class AddInjuredPersonScreen extends StatelessWidget {
  static const routeName = 'AddInjuredPersonScreen';
  final Map addIncidentMap;
  static List injuredPersonDetailsList = [];

  const AddInjuredPersonScreen({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title: DatabaseUtil.getText('addInjuredPersonPageHeading')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFloatingActionButton(
          textValue: DatabaseUtil.getText('addInjuredPersonPageDetails'),
          onPressed: () {},
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Visibility(
              visible: injuredPersonDetailsList.isNotEmpty,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomCard(
                      child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: tinierSpacing,
                        right: tinierSpacing,
                        top: tiniestSpacing,
                        bottom: tiniestSpacing),
                    trailing: CustomTextButton(
                        onPressed: () {}, textValue: StringConstants.kRemove),
                    title: Text('Injured Person Name',
                        // this will be replaced with the list data.
                        style: Theme.of(context).textTheme.small.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.mediumBlack)),
                  ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: xxTinierSpacing);
                },
              ),
            )),
        bottomNavigationBar: BottomAppBar(
          child: BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
              listener: (context, state) {
                if (state is ReportNewIncidentSaving) {
                  ProgressBar.show(context);
                } else if (state is ReportNewIncidentSaved ||
                    state is ReportNewIncidentPhotoSaved) {
                  ProgressBar.dismiss(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, IncidentListScreen.routeName,
                      arguments: false);
                } else if (state is ReportNewIncidentNotSaved) {
                  ProgressBar.dismiss(context);
                  showCustomSnackBar(
                      context, state.incidentNotSavedMessage, '');
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<ReportNewIncidentBloc>().add(
                        SaveReportNewIncident(
                            reportNewIncidentMap: addIncidentMap,
                            role: context
                                .read<IncidentFetchAndChangeRoleBloc>()
                                .roleId));
                  },
                  textValue: StringConstants.kDone)),
        ));
  }
}
