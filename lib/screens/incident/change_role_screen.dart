import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_bloc.dart';
import 'package:toolkit/blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_states.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';

import '../../blocs/incident/incidentGetAndChangeRole/incident_get_and_change_role_events.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';

class IncidentChangeRoleScreen extends StatelessWidget {
  static const routeName = 'IncidentChangeRoleScreen';

  const IncidentChangeRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<IncidentsRoleBloc>().add(
        IncidentFetchRoles(roleId: context.read<IncidentsRoleBloc>().roleId));
    return Scaffold(
        appBar: GenericAppBar(
          title: DatabaseUtil.getText('ChangeRole'),
        ),
        body: BlocConsumer<IncidentsRoleBloc, IncidentRolesStates>(
            listener: (context, state) {
          if (state is IncidentRolesFetched && state.isRoleSelected == true) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          if (state is FetchingIncidentRoles) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IncidentRolesFetched) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(top: topBottomPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: xxTiniestSpacing),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.only(bottom: xxTiniestSpacing),
                            shrinkWrap: true,
                            itemCount:
                                state.incidentFetchRolesModel.data!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: xxxMediumSpacing,
                                  child: RadioListTile(
                                      dense: true,
                                      activeColor: AppColor.deepBlue,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: Text(state.incidentFetchRolesModel
                                          .data![index].groupName),
                                      value: state.incidentFetchRolesModel
                                          .data![index].groupId,
                                      groupValue: state.roleId,
                                      onChanged: (value) {
                                        value = state.incidentFetchRolesModel
                                            .data![index].groupId;
                                        context.read<IncidentsRoleBloc>().add(
                                            IncidentChangeRole(
                                                roleId: state
                                                    .incidentFetchRolesModel
                                                    .data![index]
                                                    .groupId
                                                    .toString(),
                                                incidentFetchRolesModel: state
                                                    .incidentFetchRolesModel,
                                                isRoleSelected: true));
                                      }));
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                  thickness: kDividerThickness,
                                  height: kDividerHeight);
                            }),
                        const SizedBox(height: xxxSmallerSpacing)
                      ])),
            );
          } else if (state is IncidentRolesNotFetched) {
            return GenericReloadButton(
                onPressed: () {
                  context.read<IncidentsRoleBloc>().add(IncidentFetchRoles(
                      roleId: context.read<IncidentsRoleBloc>().roleId));
                },
                textValue: StringConstants.kReload);
          } else {
            return const SizedBox();
          }
        }));
  }
}
