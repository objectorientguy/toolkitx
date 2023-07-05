import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/incident_location_screen.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/incident_contractor_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_report_anonymously_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_bloc.dart';
import '../../blocs/pickAndUploadImage/pick_and_upload_image_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/generic_text_field.dart';
import '../../widgets/primary_button.dart';
import '../checklist/workforce/widgets/upload_image_section.dart';

class ReportNewIncidentScreen extends StatelessWidget {
  static const routeName = 'ReportNewIncidentScreen';
  final Map addIncidentMap;
  static String eventDate = '';

  const ReportNewIncidentScreen({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PickAndUploadImageBloc>().add(UploadInitial());
    return Scaffold(
      appBar: const GenericAppBar(
        title: StringConstants.kReportNewIncident,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinySpacing),
          child: SingleChildScrollView(
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
                        addIncidentMap: addIncidentMap),
                    const SizedBox(height: tinySpacing),
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
                        addIncidentMap['eventdatetime'] = '$eventDate $time';
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
                        maxLength: 250,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        onTextFieldChanged: (String textField) {
                          addIncidentMap['description'] = textField;
                        }),
                    const SizedBox(height: tinySpacing),
                    Text(StringConstants.kPhoto,
                        style: Theme.of(context)
                            .textTheme
                            .medium
                            .copyWith(color: AppColor.black)),
                    const SizedBox(height: tiniestSpacing),
                    UploadImageMenu(
                      onUploadImageResponse: (List uploadImageList) {
                        addIncidentMap['filenames'] = uploadImageList
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", "");
                      },
                    ),
                    const SizedBox(height: tiniestSpacing),
                    IncidentContractorListTile(addIncidentMap: addIncidentMap),
                  ]))),
      bottomNavigationBar: BottomAppBar(
        child: BlocListener<ReportNewIncidentBloc, ReportNewIncidentStates>(
          listener: (context, state) {
            if (state is ReportNewIncidentDateTimeDescValidated) {
              showCustomSnackBar(
                  context, state.dateTimeDescValidationMessage, '');
            } else if (state
                is ReportNewIncidentDateTimeDescValidationComplete) {
              Navigator.pushNamed(context, IncidentLocationScreen.routeName,
                  arguments: addIncidentMap);
            }
          },
          child: PrimaryButton(
              onPressed: () {
                context.read<ReportNewIncidentBloc>().add(
                    ReportNewIncidentDateTimeDescriptionValidation(
                        reportNewIncidentMap: addIncidentMap));
              },
              textValue: DatabaseUtil.getText('nextButtonText')),
        ),
      ),
    );
  }
}
