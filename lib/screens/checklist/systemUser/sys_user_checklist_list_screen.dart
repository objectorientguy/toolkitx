import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_event.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_change_role_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_filters_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_list_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/checklist/systemUser/changeRole/sys_user_change_role_states.dart';
import '../../../widgets/progress_bar.dart';

class SystemUserCheckListScreen extends StatelessWidget {
  static const routeName = 'SystemUserCheckListScreen';

  const SystemUserCheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SysUserCheckListBloc>().add(FetchList());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kChecklist),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(children: [
            BlocListener<CheckListRoleBloc, CheckListRoleStates>(
              listener: (context, state) {
                if (state is FetchingRoles) {
                  ProgressBar.show(context);
                } else if (state is RolesFetched) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                }
              },
              child: CustomIconButtonRow(
                  primaryOnPress: () {
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  },
                  secondaryOnPress: () {
                    context
                        .read<CheckListRoleBloc>()
                        .add(FetchRoles(roleName: ''));
                  },
                  clearVisible:
                      context.read<SysUserCheckListBloc>().filterData != '{}',
                  isEnabled: true,
                  clearOnPress: () {
                    context
                        .read<SysUserCheckListBloc>()
                        .add(ClearSystemUserCheckListFilter());
                    context.read<SysUserCheckListBloc>().add(FetchList());
                  }),
            ),
            const SizedBox(height: tiniest),
            SysUserListSection()
          ])),
    );
  }
}
