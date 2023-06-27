import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentList/incident_list_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/incident/widgets/list_body.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../blocs/incident/incidentList/incident_list_bloc.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import 'category_screen.dart';
import 'change_role_screen.dart';
import 'filter_screen.dart';

class IncidentListScreen extends StatelessWidget {
  static const routeName = 'IncidentListScreen';

  const IncidentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<IncidentListBloc>().add(FetchIncidentListEvent(
        roleId: context.read<IncidentFetchAndChangeRoleBloc>().roleId));
    return Scaffold(
      appBar: GenericAppBar(title: DatabaseUtil.getText('ReportanIncident')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CategoryScreen.routeName);
          },
          child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: xxTinierSpacing),
        child: Column(children: [
          CustomIconButtonRow(
              primaryOnPress: () {
                Navigator.pushNamed(context, IncidentFilterScreen.routeName);
              },
              secondaryOnPress: () {
                Navigator.pushNamed(
                    context, IncidentChangeRoleScreen.routeName);
              },
              isEnabled: true,
              clearOnPress: () {}),
          const SizedBox(height: xxTinierSpacing),
          const IncidentListBody(),
          const SizedBox(height: xxTinySpacing)
        ]),
      ),
    );
  }
}
