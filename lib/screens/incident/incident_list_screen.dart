import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/incident/widgets/list_body.dart';
import 'package:toolkit/utils/database_utils.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/text_button.dart';
import 'category_screen.dart';
import 'change_role_screen.dart';
import 'filter_screen.dart';

class IncidentListScreen extends StatelessWidget {
  static const routeName = 'IncidentListScreen';
  final bool isFromHome;

  const IncidentListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<IncidentLisAndFilterBloc>()
        .add(FetchIncidentListEvent(isFromHome: isFromHome, roleId: ''));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<IncidentLisAndFilterBloc,
                      IncidentListAndFilterStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is IncidentsFetched,
                  builder: (context, state) {
                    if (state is IncidentsFetched) {
                      return Visibility(
                          visible: state.filterMap.isNotEmpty,
                          child: CustomTextButton(
                              onPressed: () {
                                context
                                    .read<IncidentLisAndFilterBloc>()
                                    .add(ClearIncidentFilters());
                                context.read<IncidentLisAndFilterBloc>().add(
                                    FetchIncidentListEvent(
                                        isFromHome: isFromHome,
                                        roleId: context
                                            .read<
                                                IncidentFetchAndChangeRoleBloc>()
                                            .roleId));
                              },
                              textValue: DatabaseUtil.getText('Clear')));
                    } else {
                      return const SizedBox();
                    }
                  }),
              CustomIconButtonRow(
                  primaryOnPress: () {
                    Navigator.pushNamed(
                        context, IncidentFilterScreen.routeName);
                  },
                  secondaryOnPress: () {
                    Navigator.pushNamed(
                        context, IncidentChangeRoleScreen.routeName);
                  },
                  isEnabled: true,
                  clearOnPress: () {}),
            ],
          ),
          const SizedBox(height: xxTinierSpacing),
          const IncidentListBody(),
          const SizedBox(height: xxTinySpacing)
        ]),
      ),
    );
  }
}
