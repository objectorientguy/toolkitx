import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_change_role_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_filters_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_list_section.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

class SystemUserCheckListScreen extends StatelessWidget {
  static const routeName = 'SystemUserCheckListScreen';

  const SystemUserCheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SysUserCheckListBloc>().add(FetchCheckList());
    return Scaffold(
      appBar: const GenericAppBar(title: StringConstants.kChecklist),
      body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: Column(children: [
            CustomIconButtonRow(
                primaryOnPress: () {
                  Navigator.pushNamed(context, FiltersScreen.routeName);
                },
                secondaryOnPress: () {
                  Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                },
                clearVisible:
                    context.read<SysUserCheckListBloc>().filterData != '{}',
                isEnabled: true,
                clearOnPress: () {
                  context
                      .read<SysUserCheckListBloc>()
                      .add(ClearCheckListFilter());
                  context.read<SysUserCheckListBloc>().add(FetchCheckList());
                }),
            const SizedBox(height: tiniest),
            SysUserListSection()
          ])),
    );
  }
}
