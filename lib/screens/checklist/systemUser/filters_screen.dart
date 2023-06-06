import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';

import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = 'FiltersScreen';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GenericAppBar(
          title: Text(StringConstants.kFilters),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomSpacing),
            child: BlocBuilder<ChecklistBloc, ChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is CategoryFetched,
                builder: (context, state) {
                  if (state is CategoryFetching) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryFetched) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringConstants.kChecklistName,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: midTinySpacing),
                        TextFieldWidget(
                          onTextFieldValueChanged: (String textValue) {},
                        ),
                        const SizedBox(height: midTinySpacing),
                        Text(StringConstants.kCategory,
                            style: Theme.of(context).textTheme.medium),
                        const SizedBox(height: midTinySpacing),
                        Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                                tilePadding: const EdgeInsets.only(
                                    left: expansionTileMargin,
                                    right: expansionTileMargin),
                                collapsedBackgroundColor: AppColor.white,
                                maintainState: true,
                                iconColor: AppColor.deepBlue,
                                textColor: AppColor.black,
                                key: GlobalKey(),
                                title: Text(
                                    state.categoryName == ""
                                        ? StringConstants.kSelectCategory
                                        : state.categoryName,
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
                                                    .name,
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
                                                      categoryName: value));
                                            });
                                      })
                                ])),
                        const SizedBox(height: mediumSpacing),
                        PrimaryButton(
                            onPressed: () {}, textValue: StringConstants.kApply)
                      ],
                    );
                  } else if (state is CategoryError) {
                    return ShowError(onPressed: () {
                      context.read<ChecklistBloc>().add(
                          FetchCategory(userId: 'W2mt1FgZTZTQWTIvm4wU1w=='));
                    });
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
