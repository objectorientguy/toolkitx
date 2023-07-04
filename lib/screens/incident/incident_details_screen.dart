import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_bloc.dart';
import 'package:toolkit/blocs/incident/incidentDetails/incident_details_event.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/incident_custom_field_info.dart';
import 'package:toolkit/screens/incident/widgets/incident_details.dart';
import 'package:toolkit/screens/incident/widgets/incident_details_comment.dart';
import 'package:toolkit/screens/incident/widgets/incident_injured_person_list.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/incident_util.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/incident/incidentDetails/incident_details_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/incident/fetch_incidents_list_model.dart';
import '../../data/models/status_tag_model.dart';
import '../../widgets/custom_tabbar_view.dart';
import '../../widgets/generic_app_bar.dart';
import '../../widgets/status_tag.dart';

class IncidentDetailsScreen extends StatelessWidget {
  final IncidentListDatum incidentListDatum;
  static const routeName = 'IncidentDetailsScreen';

  const IncidentDetailsScreen({Key? key, required this.incidentListDatum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<IncidentDetailsBloc>().add(FetchIncidentDetailsEvent(
        incidentId: incidentListDatum.id,
        role: context.read<IncidentFetchAndChangeRoleBloc>().roleId));
    return Scaffold(
        appBar: const GenericAppBar(actions: []),
        body: BlocConsumer<IncidentDetailsBloc, IncidentDetailsStates>(
            listener: (context, state) {},
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
                                clientId: state.clientId),
                            IncidentCustomFieldInfo(
                                incidentDetailsModel:
                                    state.incidentDetailsModel),
                            PermitDetailsComment(
                                incidentDetailsModel:
                                    state.incidentDetailsModel,
                                clientId: state.clientId),
                            IncidentInjuredPersonList(
                                incidentDetailsModel:
                                    state.incidentDetailsModel)
                          ])
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
                                    .roleId));
                      },
                      textValue: StringConstants.kReload),
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
