import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/incident_location_list_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_repported_authority_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/incident_site_list_tile.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../configs/app_spacing.dart';
import '../../utils/constants/string_constants.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/primary_button.dart';

class IncidentLocationScreen extends StatelessWidget {
  static const routeName = 'IncidentLocationScreen';
  final Map addIncidentMap;

  const IncidentLocationScreen({Key? key, required this.addIncidentMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kReportNewIncident),
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
                    IncidentSiteListTile(addIncidentMap: addIncidentMap),
                    IncidentLocationListTile(addIncidentMap: addIncidentMap),
                    Text(DatabaseUtil.getText('ReportedAuthorities'),
                        style: Theme.of(context).textTheme.medium),
                    const SizedBox(height: tiniestSpacing),
                    IncidentReportedAuthorityExpansionTile(
                        addIncidentMap: addIncidentMap),
                    const SizedBox(height: mediumSpacing),
                    PrimaryButton(
                        onPressed: () {}, textValue: StringConstants.kNext),
                    const SizedBox(height: tinySpacing)
                  ]))),
    );
  }
}
