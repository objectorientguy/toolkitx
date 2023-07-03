import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import '../../../blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_icon_button_row.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../../widgets/text_button.dart';
import 'sys_user_change_role_screen.dart';
import 'sys_user_filters_screen.dart';
import 'widgets/sys_user_list_section.dart';

class SystemUserCheckListScreen extends StatelessWidget {
  static const routeName = 'SystemUserCheckListScreen';
  final bool isFromHome;
  static int page = 1;
  static List checkListData = [];

  const SystemUserCheckListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<SysUserCheckListBloc>()
        .add(FetchCheckList(isFromHome: isFromHome, page: page));
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BlocBuilder<SysUserCheckListBloc, SysUserCheckListStates>(
                    buildWhen: (previousState, currentState) {
                  if (currentState is FetchingCheckList && isFromHome == true) {
                    return true;
                  } else if (currentState is CheckListFetched) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  if (state is CheckListFetched) {
                    return Visibility(
                        visible: state.filterData != '{}',
                        child: CustomTextButton(
                            onPressed: () {
                              page = 1;
                              checkListData.clear();
                              SysUserListSection.noMoreData = false;
                              context
                                  .read<SysUserCheckListBloc>()
                                  .add(ClearCheckListFilter());
                              context.read<SysUserCheckListBloc>().add(
                                  FetchCheckList(isFromHome: false, page: 1));
                            },
                            textValue: DatabaseUtil.getText('Clear')));
                  } else {
                    return const SizedBox();
                  }
                }),
                CustomIconButtonRow(
                    primaryOnPress: () {
                      Navigator.pushNamed(context, FiltersScreen.routeName);
                    },
                    secondaryOnPress: () {
                      Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                    },
                    isEnabled: true,
                    clearOnPress: () {})
              ]),
              const SizedBox(height: tiniestSpacing),
              SysUserListSection(checkListData: checkListData)
            ])));
  }
}
