import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../blocs/incident/incidentDetails/incident_details_bloc.dart';
import '../../blocs/incident/incidentDetails/incident_details_event.dart';
import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/constants/string_constants.dart';
import '../../utils/incident_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/error_section.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';
import 'widgets/incident_custom_field_info.dart';
import 'widgets/incident_custom_timeline.dart';
import 'widgets/incident_details.dart';
import 'widgets/incident_details_comment.dart';
import 'widgets/incident_injured_person_tab.dart';
import 'widgets/incident_link_permit_list.dart';
import 'incident_pop_up_menu_screen.dart';

class IncidentDetailsScreen extends StatelessWidget {
  final IncidentListDatum incidentListDatum;
  static const routeName = 'IncidentDetailsScreen';

  const IncidentDetailsScreen({Key? key, required this.incidentListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<IncidentDetailsBloc>().add(FetchIncidentDetailsEvent(
        incidentId: incidentListDatum.id,
        role: context.read<IncidentFetchAndChangeRoleBloc>().roleId,
        initialIndex: 0));
    return Scaffold(
        appBar: GenericAppBar(actions: [
          BlocBuilder<IncidentDetailsBloc, IncidentDetailsStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is IncidentDetailsFetched,
              builder: (context, state) {
                if (state is IncidentDetailsFetched) {
                  Map incidentDetailsMap = state.editIncidentDetailsMap;
                  return IncidentDetailsPopUpMenu(
                      incidentDetailsMap: incidentDetailsMap,
                      incidentDetailsModel: state.incidentDetailsModel);
                } else {
                  return const SizedBox();
                }
              })
        ]),
        body: BlocBuilder<IncidentDetailsBloc, IncidentDetailsStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingIncidentDetails ||
                currentState is IncidentDetailsFetched ||
                currentState is IncidentDetailsNotFetched,
            builder: (context, state) {
              if (state is FetchingIncidentDetails) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is IncidentDetailsFetched) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: xxTinierSpacing),
                    child: Column(children: [
                      Card(
                          color: AppColor.white,
                          elevation: kCardElevation,
                          child: ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: xxTinierSpacing),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(incidentListDatum.refno,
                                            style: Theme.of(context)
                                                .textTheme
                                                .medium),
                                        StatusTag(tags: [
                                          StatusTagModel(
                                              title: state.incidentDetailsModel
                                                  .data!.statusText,
                                              bgColor: AppColor.deepBlue)
                                        ])
                                      ])))),
                      const SizedBox(height: xxTinierSpacing),
                      const Divider(
                          height: kDividerHeight, thickness: kDividerWidth),
                      CustomTabBarView(
                          lengthOfTabs: 6,
                          tabBarViewIcons: IncidentUtil().tabBarViewIcons,
                          tabBarViewWidgets: [
                            IncidentDetails(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                clientId: state.clientId,
                                initialIndex: 0),
                            IncidentCustomFieldInfo(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                initialIndex: 1),
                            PermitDetailsComment(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                clientId: state.clientId,
                                initialIndex: 2),
                            IncidentInjuredPersonTab(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                initialIndex: 3,
                                incidentListDatum: incidentListDatum),
                            IncidentCustomTimeLine(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                initialIndex: 4),
                            IncidentLinkPermitList(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                incidentListDatum: incidentListDatum,
                                initialIndex: 5)
                          ],
                          initialIndex: context
                              .read<IncidentDetailsBloc>()
                              .incidentTabIndex)
                    ]));
              } else if (state is IncidentDetailsNotFetched) {
                return Center(
                    child: GenericReloadButton(
                        onPressed: () {
                          context.read<IncidentDetailsBloc>().add(
                              FetchIncidentDetailsEvent(
                                  incidentId: incidentListDatum.id,
                                  role: context
                                      .read<IncidentFetchAndChangeRoleBloc>()
                                      .roleId,
                                  initialIndex: 0));
                        },
                        textValue: StringConstants.kReload));
              } else {
                return const SizedBox();
              }
            }));
  }
}
