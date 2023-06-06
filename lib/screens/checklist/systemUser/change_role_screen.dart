import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../onboarding/widgets/custom_card.dart';

class ChangeRoleScreen extends StatelessWidget {
  static const routeName = 'ChangeRoleScreen';

  const ChangeRoleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: Text(StringConstants.kChangeRole),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: BlocConsumer<ChecklistBloc, ChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is RolesFetched,
                listenWhen: (previousState, currentState) =>
                    currentState is RolesFetched &&
                    currentState.isChanged == true,
                listener: (context, state) {
                  if (state is RolesFetched) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is RolesFetched) {
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
                                      state.checkListRolesModel.data!.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                        dense: true,
                                        activeColor: AppColor.deepBlue,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Text(state.checkListRolesModel
                                            .data![index].groupName
                                            .toString()),
                                        value: state.checkListRolesModel
                                            .data![index].groupName,
                                        groupValue: state.roleName,
                                        onChanged: (value) {
                                          value = state.checkListRolesModel
                                              .data![index].groupName;
                                          context.read<ChecklistBloc>().add(
                                              ChangeRoles(
                                                  roleId:
                                                      state.checkListRolesModel
                                                          .data![index].groupId
                                                          .toString(),
                                                  roleName: state
                                                      .checkListRolesModel
                                                      .data![index]
                                                      .groupName
                                                      .toString(),
                                                  checkListRolesModel:
                                                      state.checkListRolesModel,
                                                  isChanged: true));
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                        thickness: kDividerThickness,
                                        height: kDividerHeight);
                                  })),
                          const SizedBox(height: mediumSpacing)
                        ]);
                  } else if (state is FetchRolesError) {
                    return ShowError(onPressed: () {
                      context
                          .read<ChecklistBloc>()
                          .add(FetchRoles(userId: 'MQFmIsmjOcA38gtYss+3Tw=='));
                    });
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
