import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_events.dart';
import 'package:toolkit/blocs/report_new_incident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/report_incident/widgets/location_expansion_tile.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../configs/app_spacing.dart';
import 'health_safety_screen.dart';
import 'widgets/report_authority_expansion_tile.dart';
import 'widgets/site_expansion_tile.dart';

class ReportIncidentLocationScreen extends StatelessWidget {
  static const routeName = 'ReportIncidentLocationScreen';

  const ReportIncidentLocationScreen({Key? key}) : super(key: key);

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
            if (state is ReportIncidentLocationScreenLoaded) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kSite,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        SiteExpansionTile(
                            site: state.site,
                            location: state.location,
                            reportToAuthorities: state.reportToAuthorities),
                        const SizedBox(height: tinySpacing),
                        Visibility(
                            visible: state.site == 'Other',
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConstants.kOtherSite,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: tiniestSpacing),
                                  const TextFieldWidget(
                                      hintText: StringConstants.kOtherSite),
                                  const SizedBox(height: tinySpacing)
                                ])),
                        Text(StringConstants.kLocation,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        LocationExpansionTile(
                            site: state.site,
                            location: state.location,
                            reportToAuthorities: state.reportToAuthorities),
                        const SizedBox(height: tinySpacing),
                        Visibility(
                            visible: state.location == 'Other',
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(StringConstants.kOtherLocation,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: tiniestSpacing),
                                  const TextFieldWidget(
                                      hintText: StringConstants.kOtherLocation),
                                  const SizedBox(height: tinySpacing)
                                ])),
                        Text(StringConstants.kReportToAuthorities,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tiniestSpacing),
                        ReportAuthoritiesExpansionTile(
                            site: state.site,
                            location: state.location,
                            reportToAuthorities: state.reportToAuthorities),
                        Visibility(
                            visible: state.reportToAuthorities ==
                                StringConstants.kYes,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: tinySpacing),
                                  Text(StringConstants.kAuthorityReportedTo,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: tiniestSpacing),
                                  const TextFieldWidget(
                                      hintText: StringConstants.kAuthorityName),
                                  const SizedBox(height: tinySpacing),
                                  Text(StringConstants.kReportedWhen,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: tiniestSpacing),
                                  const TextFieldWidget(
                                      hintText: StringConstants.kSelectDate),
                                  const SizedBox(height: tinySpacing),
                                  Text(StringConstants.kTime,
                                      style:
                                          Theme.of(context).textTheme.medium),
                                  const SizedBox(height: tiniestSpacing),
                                  const TextFieldWidget(
                                      hintText: StringConstants.kSelectTime),
                                  const SizedBox(height: tinySpacing)
                                ])),
                        const SizedBox(height: mediumSpacing),
                        PrimaryButton(
                            onPressed: () {
                              context
                                  .read<ReportIncidentBloc>()
                                  .add(HealthData(healthData: 'null'));
                              Navigator.pushNamed(context,
                                  ReportIncidentHealthSafety.routeName);
                            },
                            textValue: StringConstants.kNext),
                        const SizedBox(height: tinySpacing)
                      ]));
            } else {
              return const SizedBox();
            }
          })),
    );
  }
}
