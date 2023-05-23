import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';

import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';
import 'add_injured_person_screen.dart';
import 'widgets/health_safety_expansion_tile.dart';

class ReportIncidentHealthSafety extends StatelessWidget {
  static const routeName = 'ReportIncidentHealthSafety';

  const ReportIncidentHealthSafety({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const GenericAppBar(title: Text(StringConstants.kReportNewIncident)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomSpacing),
        child: BlocBuilder<ReportIncidentBloc, ReportIncidentStates>(
            builder: (context, state) {
          if (state is ReportIncidentHealthScreenLoaded) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringConstants.kSelectHealthAndSafety,
                      style: Theme.of(context).textTheme.medium),
                  const SizedBox(height: tiniestSpacing),
                  HealthSafetyExpansionTile(
                    selectedData: state.healthData,
                  ),
                  const SizedBox(height: tinySpacing),
                  Text(StringConstants.kImmediateActionTaken,
                      style: Theme.of(context).textTheme.medium),
                  const SizedBox(height: tiniestSpacing),
                  const TextFieldWidget(maxLines: 3),
                  const SizedBox(height: mediumSpacing),
                  PrimaryButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AddInjuredPersonScreen.routeName);
                      },
                      textValue: StringConstants.kNext)
                ]);
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
