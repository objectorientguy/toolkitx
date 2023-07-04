import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/incident_location_screen.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/incident_contractor_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_report_anonymously_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/utils/database_utils.dart';
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
                      onUploadImageResponse: (List uploadImageList) {},
                    ),
                    const SizedBox(height: tiniestSpacing),
                    IncidentContractorListTile(addIncidentMap: addIncidentMap),
                    const SizedBox(height: mediumSpacing),
                    PrimaryButton(
                        onPressed: () {
                          log("map====>$addIncidentMap}");
                          Navigator.pushNamed(
                              context, IncidentLocationScreen.routeName,
                              arguments: addIncidentMap);
                        },
                        textValue: StringConstants.kNext)
                  ]))),
    );
  }
}
