import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BlocConsumer<ScheduleDatesResponseBloc, ScheduleDatesResponseStates>(
          buildWhen: (previousState, currentState) =>
              currentState is FetchingWorkforceList ||
              currentState is WorkforceListFetched,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchingWorkforceList) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorkforceListFetched) {
              return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.checkListWorkforceListModel.data!.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(tinier),
                                title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: tiniest),
                                    child: Text(
                                        state.checkListWorkforceListModel
                                            .data![index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(color: AppColor.black))),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${state.checkListWorkforceListModel.data![index].jobtitle} -- ${state.checkListWorkforceListModel.data![index].company}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: tiniest),
                                      Text(
                                          'Response Date: ${state.checkListWorkforceListModel.data![index].responsedate}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
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
                                      ),
                                      const SizedBox(height: tiniest),
                                      FetchPdfSection(
                                          responseId: state
                                              .checkListWorkforceListModel
                                              .data![index]
                                              .responseid)
                                    ]),
                                trailing: Visibility(
                                    // visible: state
                                    //         .checkListWorkforceListModel
                                    //         .data![index]
                                    //         .responseid
                                    //         .isNotEmpty &&
                                    //     state
                                    //             .checkListWorkforceListModel
                                    //             .data![index]
                                    //             .isdeptapprove ==
                                    //         "0",
                                    child: Checkbox(
                                        value: state.selectedIdsList.contains(
                                            state.checkListWorkforceListModel
                                                .data![index].responseid),
                                        onChanged: (value) {
                                          context
                                              .read<ScheduleDatesResponseBloc>()
                                              .add(CheckBoxCheck(
                                                  responseId: state
                                                      .checkListWorkforceListModel
                                                      .data![index]
                                                      .responseid,
                                                  checkListWorkforceListModel: state
                                                      .checkListWorkforceListModel,
                                                  responseIdList:
                                                      state.selectedIdsList));
                                        }))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: xxTinySpacing);
                      }));
            } else if (state is WorkforceListError) {
              return GenericReloadButton(
                onPressed: () {},
                textValue: StringConstants.kReload,
              );
            } else {
              return const SizedBox();
            }
          })
    ]));
  }
}
