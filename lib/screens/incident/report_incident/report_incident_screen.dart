import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../blocs/report_new_incident/report_new_incident_events.dart';
import '../../../blocs/report_new_incident/report_new_incident_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/primary_button.dart';
import '../../onboarding/widgets/text_field.dart';
import '../widgets/date_picker.dart';
import '../widgets/time_picker.dart';
import 'category_screen.dart';
import 'location_screen.dart';
import 'widgets/contractor_expansion_tile.dart';
import 'widgets/report_anonymously_expansion_tile.dart';

class ReportIncidentScreen extends StatelessWidget {
  static const routeName = 'ReportIncidentScreen';

  const ReportIncidentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReportIncidentBloc>().add(ReportIncidentScreenExpansionChange(
        reportAnonymously: StringConstants.kNo, contractor: 'null'));
    return Scaffold(
      appBar: GenericAppBar(
        title: const Text(StringConstants.kReportNewIncident),
        onPressedFunction: () {
          Navigator.popAndPushNamed(context, CategoryScreen.routeName);
        },
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: topBottomSpacing),
          child: BlocBuilder<ReportIncidentBloc, ReportIncidentStates>(
              builder: (context, state) {
            if (state is ReportIncidentScreenLoaded) {
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kReportAnonymously,
                            style: Theme.of(context)
                                .textTheme
                                .medium
                                .copyWith(color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        ReportAnonymouslyExpansionTile(
                            contractor: state.contractor,
                            reportAnonymously: state.reportAnonymously),
                        const SizedBox(height: tinySpacing),
                        Text(StringConstants.kContractor,
                            style: Theme.of(context)
                                .textTheme
                                .medium
                                .copyWith(color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        ContractorExpansionTile(
                            contractor: state.contractor,
                            reportAnonymously: state.reportAnonymously),
                        const SizedBox(height: tinySpacing),
                        Text(StringConstants.kDateOfIncident,
                            style: Theme.of(context)
                                .textTheme
                                .medium
                                .copyWith(color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        DatePickerTextField(
                            hintText: StringConstants.kSelectDate),
                        const SizedBox(height: tinySpacing),
                        Text(StringConstants.kTime,
                            style: Theme.of(context)
                                .textTheme
                                .medium
                                .copyWith(color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        TimePickerTextField(
                            hintText: StringConstants.kSelectTime),
                        const SizedBox(height: tinySpacing),
                        Text(StringConstants.kDetailedDescription,
                            style: Theme.of(context)
                                .textTheme
                                .medium
                                .copyWith(color: AppColor.black)),
                        const SizedBox(height: tiniestSpacing),
                        const TextFieldWidget(
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text),
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
                            onPressed: () {
                              context.read<ReportIncidentBloc>().add(
                                  LocationScreenExpansionChange(
                                      otherSite: 'null',
                                      otherLocation: 'null',
                                      reportToAuthorities: 'null'));
                              Navigator.pushNamed(context,
                                  ReportIncidentLocationScreen.routeName);
                            },
                            textValue: StringConstants.kNext)
                      ]));
            } else {
              return const SizedBox();
            }
          })),
    );
  }
}
