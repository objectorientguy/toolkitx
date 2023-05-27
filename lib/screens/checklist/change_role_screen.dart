import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_events.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/utils/constants/string_constants.dart';

import '../../blocs/systemUser/checklist/checklist_states.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/generic_app_bar.dart';
import '../onboarding/widgets/custom_card.dart';

class ChangeRoleScreen extends StatefulWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({Key? key}) : super(key: key);

  @override
  State<ChangeRoleScreen> createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends State<ChangeRoleScreen> {
  String? changeRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: Text(StringConstants.kChangeRole),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightMargin,
                  right: leftRightMargin,
                  top: topBottomSpacing),
              child: BlocBuilder<ChecklistBloc, ChecklistStates>(
                  builder: (context, state) {
                if (state is FetchingRoles) {
                  return const CircularProgressIndicator();
                } else if (state is RolesFetched) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: tiniestSpacing),
                        CustomCard(
                            elevation: kZeroElevation,
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    bottom: tiniestSpacing),
                                shrinkWrap: true,
                                itemCount:
                                    state.getCheckListRolesModel.data!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: largeSpacing,
                                      child: RadioListTile(
                                        dense: true,
                                        activeColor: AppColor.deepBlue,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(state.getCheckListRolesModel
                                            .data![index].groupName),
                                        value: state.getCheckListRolesModel
                                            .data![index].groupName,
                                        groupValue: changeRole,
                                        onChanged: (value) {
                                          changeRole = value;
                                          log("chnagee roleee====>$changeRole");
                                          context.read<ChecklistBloc>().add(
                                              ChangeRoles(
                                                  rolesValue: changeRole!,
                                                  rolesString: state
                                                      .getCheckListRolesModel
                                                      .data![index]
                                                      .groupId));
                                        },
                                      ));
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                      thickness: kDividerThickness,
                                      height: kDividerHeight);
                                })),
                        const SizedBox(height: mediumSpacing)
                      ]);
                } else if (state is FetchRolesError) {
                  return ShowError(onPressed: () {});
                } else {
                  return const SizedBox();
                }
              })),
        ));
  }
}
