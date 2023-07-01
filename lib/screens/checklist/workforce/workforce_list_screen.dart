import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/custom_tag_container.dart';
import 'package:toolkit/screens/checklist/workforce/workforce_questions_list_screen.dart';
import 'package:toolkit/widgets/error_section.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_bloc.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_events.dart';
import '../../../blocs/checklist/workforce/workforceList/workforce_list_states.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/generic_app_bar.dart';

class WorkForceListScreen extends StatelessWidget {
  static const routeName = 'WorkForceListScreen';

  const WorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkForceListBloc>().add(FetchWorkForceList());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocBuilder<WorkForceListBloc, WorkForceListStates>(
                builder: (context, state) {
              if (state is FetchingList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ListFetched) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.workforceGetCheckListModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(tinierSpacing),
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: xxTinierSpacing),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            state.workforceGetCheckListModel
                                                .data![index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    color: AppColor.black)),
                                        const SizedBox(width: xxTinierSpacing),
                                        Visibility(
                                            visible: state
                                                    .workforceGetCheckListModel
                                                    .data![index]
                                                    .isdraft ==
                                                1,
                                            child: Text(
                                                '[${StringConstants.kDraft}]',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .xSmall
                                                    .copyWith(
                                                        color:
                                                            AppColor.errorRed)))
                                      ])),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${DatabaseUtil.getText('Assignedate')}: ${state.workforceGetCheckListModel.data![index].submitdate}  -- ${DatabaseUtil.getText('Dueon')}: ${state.workforceGetCheckListModel.data![index].overduedate}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(color: AppColor.grey)),
                                    const SizedBox(height: xxTinierSpacing),
                                    Text(
                                        '${state.workforceGetCheckListModel.data![index].categoryname} -- ${state.workforceGetCheckListModel.data![index].subcategoryname}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xSmall
                                            .copyWith(color: AppColor.grey)),
                                    const SizedBox(height: xxTinierSpacing),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isrejected !=
                                          '0',
                                      child: const CustomTagContainer(
                                          color: AppColor.errorRed,
                                          textValue:
                                              StringConstants.kNotAccepted),
                                    ),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isoverdue !=
                                          '0',
                                      child: const CustomTagContainer(
                                          color: AppColor.yellow,
                                          textValue: StringConstants.kOverdue),
                                    ),
                                    Visibility(
                                      visible: state.workforceGetCheckListModel
                                              .data![index].isdraft ==
                                          0,
                                      child: const CustomTagContainer(
                                          color: AppColor.lightGreen,
                                          textValue:
                                              StringConstants.kSubmitted),
                                    ),
                                  ]),
                              onTap: () {
                                Map checklistDataMap = {
                                  "scheduleId": state.workforceGetCheckListModel
                                      .data![index].scheduleid
                                      .toString(),
                                  "checklistId": state
                                      .workforceGetCheckListModel
                                      .data![index]
                                      .id,
                                  "isDraft": state.workforceGetCheckListModel
                                      .data![index].isdraft,
                                  "isRejected": state.workforceGetCheckListModel
                                      .data![index].isrejected
                                };
                                Navigator.pushNamed(
                                    context, WorkForceQuestionsScreen.routeName,
                                    arguments: checklistDataMap);
                              }));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: xxTinySpacing);
                    });
              } else if (state is ListNotFetched) {
                return GenericReloadButton(
                    onPressed: () {
                      context
                          .read<WorkForceListBloc>()
                          .add(FetchWorkForceList());
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox();
              }
            })));
  }
}
