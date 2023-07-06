import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/database_utils.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';

class IncidentDetailsPopUpMenu extends StatelessWidget {
  const IncidentDetailsPopUpMenu({Key? key}) : super(key: key);

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
                    // CategoryScreen.addIncidentMap = // model of details;
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
