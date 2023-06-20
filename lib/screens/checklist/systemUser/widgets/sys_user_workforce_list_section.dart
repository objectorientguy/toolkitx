import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/systemUser/changeRole/sys_user_change_role_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_events.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import 'sys_user_fetch_pdf_section.dart';

class WorkForceListSection extends StatelessWidget {
  const WorkForceListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocBuilder<ScheduleDatesResponseBloc,
                ScheduleDatesResponseStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingWorkforceList ||
                currentState is WorkforceListFetched ||
                currentState is WorkforceListError,
            builder: (context, state) {
              if (state is FetchingWorkforceList) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WorkforceListFetched) {
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            state.checkListWorkforceListModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  dense: true,
                                  minVerticalPadding: 0.0,
                                  contentPadding: const EdgeInsets.only(
                                      left: tiniest,
                                      bottom: tiniest,
                                      top: tiniest),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.checkListWorkforceListModel
                                              .data![index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .small
                                              .copyWith(color: AppColor.black)),
                                      FetchPdfSection(
                                          responseId: context
                                              .read<ScheduleDatesResponseBloc>()
                                              .responseId)
                                    ],
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${state.checkListWorkforceListModel.data![index].jobtitle} -- ${state.checkListWorkforceListModel.data![index].company}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: tiniest),
                                        Text(
                                            'Response Date: ${state.checkListWorkforceListModel.data![index].responsedate}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: tiniest),
                                        Visibility(
                                          visible: state
                                                  .checkListWorkforceListModel
                                                  .data![index]
                                                  .approvalstatus ==
                                              1,
                                          child: Text('Approved',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .xSmall
                                                  .copyWith(
                                                      color: AppColor.grey)),
                                        )
                                      ]),
                                  trailing: Visibility(
                                      visible: state
                                              .checkListWorkforceListModel
                                              .data![index]
                                              .responseid
                                              .isNotEmpty &&
                                          state.checkListWorkforceListModel
                                                  .data![index].isdeptapprove ==
                                              "0",
                                      child: Checkbox(
                                          value: state.selectedIResponseIdList
                                              .contains(state
                                                  .checkListWorkforceListModel
                                                  .data![index]
                                                  .responseid),
                                          onChanged: (value) {
                                            context
                                                .read<
                                                    ScheduleDatesResponseBloc>()
                                                .add(CheckBoxCheck(
                                                    responseId: state
                                                        .checkListWorkforceListModel
                                                        .data![index]
                                                        .responseid,
                                                    checkListWorkforceListModel:
                                                        state
                                                            .checkListWorkforceListModel,
                                                    responseIdList: state
                                                        .selectedIResponseIdList));
                                          }))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: xxTinySpacing);
                        }));
              } else if (state is WorkforceListError) {
                return GenericReloadButton(
                  onPressed: () {
                    context.read<ScheduleDatesResponseBloc>().add(
                        CheckScheduleDatesResponse(
                            getChecklistDetailsData: context
                                .read<ScheduleDatesResponseBloc>()
                                .getChecklistDetailsData!,
                            scheduleId: context
                                .read<ScheduleDatesResponseBloc>()
                                .scheduleId,
                            role: context.read<CheckListRoleBloc>().roleId));
                  },
                  textValue: StringConstants.kReload,
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
