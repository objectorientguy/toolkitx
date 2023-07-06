import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/reportNewIncident/report_new_incident_events.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../data/models/incident/incident_details_model.dart';
import 'category_screen.dart';

class IncidentDetailsPopUpMenu extends StatelessWidget {
  final IncidentDetailsModel incidentDetailsModel;

  const IncidentDetailsPopUpMenu({Key? key, required this.incidentDetailsModel})
      : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, String position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<IncidentDetailsBloc>()
        .add(IncidentDetailsFetchPopUpMenuItems(popUpMenuItems: const []));
    return BlocBuilder<IncidentDetailsBloc, IncidentDetailsStates>(
        buildWhen: (previousState, currentState) =>
            currentState is IncidentDetailsPopUpMenuItemsFetched,
        builder: (context, state) {
          if (state is IncidentDetailsPopUpMenuItemsFetched) {
            return PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCardRadius),
                ),
                iconSize: kIconSize,
                icon: const Icon(Icons.more_vert_outlined),
                offset: const Offset(0, xxTinierSpacing),
                onSelected: (value) {
                  if (value == DatabaseUtil.getText('AddComments')) {}
                  if (value == DatabaseUtil.getText('EditIncident')) {
                    Navigator.pushNamed(context, CategoryScreen.routeName);
                  }
                  if (value == DatabaseUtil.getText('Report')) {}
                  if (value == DatabaseUtil.getText('Markasresolved')) {}
                  if (value == DatabaseUtil.getText('GenerateReport')) {}
                },
                position: PopupMenuPosition.under,
                itemBuilder: (BuildContext context) {
                  return List.generate(state.popUpMenuItems.length, (index) {
                    return _buildPopupMenuItem(
                        context,
                        state.popUpMenuItems[index],
                        state.popUpMenuItems[index]);
                  });
                });
          } else {
            return const SizedBox();
          }
        });
  }
}
