import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/string_extension.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/error_section.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/progress_bar.dart';
import 'system_user_list_screen.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'FiltersScreen';

  FiltersScreen({Key? key}) : super(key: key);
  final Map filterDataMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: StringConstants.kFilters,
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            child: BlocConsumer<ChecklistBloc, ChecklistStates>(
                listener: (context, state) {
                  if (state is SavingFilterData) {
                    ProgressBar.show(context);
                  } else if (state is SavedFilterData) {
                    ProgressBar.dismiss(context);
                    Navigator.pushReplacementNamed(
                        context, SystemUserCheckListScreen.routeName);
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is CategoryFetched,
                builder: (context, state) {
                  if (state is CategoryFetched) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kChecklistName,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tinier),
                        TextFieldWidget(
                          onTextFieldChanged: (String textValue) {
                            filterDataMap["checklistname"] = textValue;
                            log("value=====>${filterDataMap["checklistname"]}");
                          },
                        ),
                        const SizedBox(height: tinier),
                        Text(StringConstants.kCategory,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: tinier),
                        Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                tilePadding: const EdgeInsets.only(
                                    left: kExpansionTileMargin,
                                    right: kExpansionTileMargin),
                                collapsedBackgroundColor: AppColor.white,
                                maintainState: true,
                                iconColor: AppColor.deepBlue,
                                textColor: AppColor.black,
                                key: GlobalKey(),
                                title: Text(
                                    state.categoryName == ""
                                        ? StringConstants.kSelectCategory
                                        : state.categoryName.capitalize(),
                                    style: Theme.of(context).textTheme.xSmall),
                                children: [
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                      state.getFilterCategoryData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            activeColor: AppColor.deepBlue,
                                            title: Text(
                                                state.getFilterCategoryData
                                                    .elementAt(index)
                                                    .name
                                                    .capitalize(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .xSmall),
                                            controlAffinity:
                                            ListTileControlAffinity
                                                .trailing,
                                            value: state.getFilterCategoryData
                                                .elementAt(index)
                                                .name,
                                            groupValue: state.categoryName,
                                            onChanged: (value) {
                                              value = state
                                                  .getFilterCategoryData
                                                  .elementAt(index)
                                                  .name;
                                              context.read<ChecklistBloc>().add(
                                                  ChangeCategory(
                                                      getFilterCategoryData: state
                                                          .getFilterCategoryData,
                                                      categoryName: value,
                                                      categoryId: state
                                                          .getFilterCategoryData
                                                          .elementAt(index)
                                                          .id
                                                          .toString()));
                                            });
                                      })
                                ])),
                        const SizedBox(height: xxxSmallerSpacing),
                        PrimaryButton(
                            onPressed: () {
                              context.read<ChecklistBloc>().add(FilterChecklist(
                                  filterChecklistMap: filterDataMap));
                            },
                            textValue: StringConstants.kApply)
                      ],
                    );
                  } else if (state is CategoryError) {
                    return GenericReloadButton(
                        onPressed: () {
                          context.read<ChecklistBloc>().add(FetchCategory());
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
