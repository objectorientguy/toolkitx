import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_events.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/screens/checklist/change_role_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/filters_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/custom_icon_button_row.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'list_section.dart';

class SystemUserCheckListScreen extends StatelessWidget {
  static const routeName = 'SystemUserCheckListScreen';

  const SystemUserCheckListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ChecklistBloc>().add(FetchChecklist());
    return Scaffold(
        appBar: const GenericAppBar(title: Text(StringConstants.kChecklist)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: midTiniestSpacing),
            child: Column(children: [
              CustomIconButtonRow(
                  primaryOnPress: () {
                    Navigator.pushNamed(context, FiltersScreen.routeName);
                  },
                  secondaryOnPress: () {
                    Navigator.pushNamed(context, ChangeRoleScreen.routeName);
                  },
                  clearVisible: false,
                  clearOnPress: () {}),
              const SizedBox(height: tiniestSpacing),
              const SystemUserListSection(),
              const SizedBox(height: tinySpacing)
            ])));
  }
}
