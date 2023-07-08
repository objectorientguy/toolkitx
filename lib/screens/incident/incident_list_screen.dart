import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_bloc.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_event.dart';
import '../../blocs/incident/incidentListAndFilter/incident_list_and_filter_state.dart';
import '../../configs/app_spacing.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/text_button.dart';
import 'category_screen.dart';
import 'change_role_screen.dart';
import 'incident_filter_screen.dart';
import 'widgets/list_body.dart';

class IncidentListScreen extends StatelessWidget {
  static const routeName = 'IncidentListScreen';
  final bool isFromHome;
  static int page = 1;

  const IncidentListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<IncidentLisAndFilterBloc>()
        .add(FetchIncidentListEvent(isFromHome: isFromHome, page: 1));
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ReportanIncident')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              CategoryScreen.addIncidentMap = {};
              Navigator.pushNamed(context, CategoryScreen.routeName);
            },
            child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<IncidentLisAndFilterBloc,
                        IncidentListAndFilterStates>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is FetchingIncidents && isFromHome == true) {
                    return true;
                  } else if (currentState is IncidentsFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is IncidentsFetched) {
                    return Visibility(
                        visible: state.filterMap.isNotEmpty,
                        child: CustomTextButton(
                            onPressed: () {
                              page = 1;
                              IncidentListBody.incidentListData.clear();
                              IncidentListBody.noMoreData = false;
                              context
                                  .read<IncidentLisAndFilterBloc>()
                                  .add(const ClearIncidentFilters());
                              context.read<IncidentLisAndFilterBloc>().add(
                                  FetchIncidentListEvent(
                                      isFromHome: isFromHome, page: 1));
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
                    clearOnPress: () {})
              ]),
              const SizedBox(height: xxTinierSpacing),
              const IncidentListBody(),
              const SizedBox(height: xxTinySpacing)
            ])));
  }
}
