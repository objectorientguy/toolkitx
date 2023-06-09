import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/error_section.dart';
import '../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/generic_app_bar.dart';
import '../widgets/custom_tags_container.dart';
import 'questions_list_screen.dart';

class WorkForceListScreen extends StatelessWidget {
  static const routeName = 'WorkForceListScreen';

  const WorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WorkforceChecklistBloc>().add(FetchChecklist());
    return Scaffold(
        appBar: const GenericAppBar(title: StringConstants.kChecklist),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: BlocBuilder<WorkforceChecklistBloc,
                    WorkforceChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingChecklist ||
                    currentState is ChecklistFetched ||
                    currentState is FetchChecklistError,
                builder: (context, state) {
                  if (state is FetchingChecklist) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChecklistFetched) {
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.getCheckListModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  contentPadding: const EdgeInsets.all(tinier),
                                  title: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: xxTinierSpacing),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                state.getCheckListModel
                                                    .data![index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .small
                                                    .copyWith(
                                                        color: AppColor.black)),
                                            const SizedBox(
                                                width: xxTinierSpacing),
                                            Visibility(
                                                visible: state.getCheckListModel
                                                        .data![index].isdraft ==
                                                    1,
                                                child: Text(
                                                    StringConstants.kDraft,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color: AppColor
                                                                .errorRed)))
                                          ])),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Assign Date: ${state.getCheckListModel.data![index].submitdate}  -- Due on: ${state.getCheckListModel.data![index].overduedate}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: xxTinierSpacing),
                                        Text(
                                            '${state.getCheckListModel.data![index].categoryname} -- ${state.getCheckListModel.data![index].subcategoryname}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: xxTinierSpacing),
                                        Visibility(
                                          visible: state.getCheckListModel
                                                  .data![index].isrejected !=
                                              '0',
                                          child: const CustomTagContainer(
                                              color: AppColor.errorRed,
                                              textValue:
                                                  StringConstants.kNotAccepted),
                                        ),
                                        Visibility(
                                          visible: state.getCheckListModel
                                                  .data![index].isoverdue !=
                                              '0',
                                          child: const CustomTagContainer(
                                              color: AppColor.yellow,
                                              textValue:
                                                  StringConstants.kOverdue),
                                        ),
                                        Visibility(
                                          visible: state.getCheckListModel
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
                                      "scheduleId": state.getCheckListModel
                                          .data![index].scheduleid
                                          .toString(),
                                      "checklistId": state
                                          .getCheckListModel.data![index].id,
                                      "isDraft": state.getCheckListModel
                                          .data![index].isdraft,
                                      "isRejected": state.getCheckListModel
                                          .data![index].isrejected
                                    };
                                    Navigator.pushNamed(context,
                                        WorkForceQuestionsList.routeName,
                                        arguments: checklistDataMap);
                                  }));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: xxTinySpacing);
                        });
                  } else if (state is FetchChecklistError) {
                    return GenericReloadButton(
                        onPressed: () {
                          context
                              .read<WorkforceChecklistBloc>()
                              .add(FetchChecklist());
                        },
                        textValue: StringConstants.kReload);
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
