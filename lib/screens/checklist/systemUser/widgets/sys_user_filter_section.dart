import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/checkList/sys_user_checklist_state.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/sys_user_checklist_list_screen.dart';
import 'package:toolkit/screens/checklist/systemUser/widgets/sys_user_filter_expansion_tile_layout.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_bloc.dart';
import '../../../../blocs/checklist/systemUser/checkList/sys_user_checklist_event.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/generic_text_field.dart';
import '../../../../widgets/primary_button.dart';

class FilterSection extends StatelessWidget {
  FilterSection({Key? key}) : super(key: key);
  final Map filterDataMap = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.kChecklistName,
              style: Theme.of(context).textTheme.medium),
          const SizedBox(height: tinier),
          TextFieldWidget(
              maxLength: 80,
              onTextFieldChanged: (String textValue) {
                filterDataMap["checklistname"] = textValue;
              }),
          const SizedBox(height: tinier),
          Text(StringConstants.kCategory,
              style: Theme.of(context).textTheme.medium),
          const SizedBox(height: tinier),
          FilterExpansionTileLayout(onCategoryChanged: (String category) {
            filterDataMap["category"] = category;
          }),
          const SizedBox(height: xxxSmallerSpacing),
          BlocListener<SysUserCheckListBloc, SysUserCheckListStates>(
              listener: (context, state) {
                if (state is SavingFilterData) {
                  ProgressBar.show(context);
                } else if (state is SavedFilterData) {
                  ProgressBar.dismiss(context);
                  Navigator.pushReplacementNamed(
                      context, SystemUserCheckListScreen.routeName);
                }
              },
              child: PrimaryButton(
                  onPressed: () {
                    context.read<SysUserCheckListBloc>().add(
                        FilterChecklist(filterChecklistMap: filterDataMap));
                  },
                  textValue: StringConstants.kApply))
        ],
      ),
    );
  }
}
