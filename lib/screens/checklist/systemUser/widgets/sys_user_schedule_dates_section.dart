import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/systemUser/changeRole/sys_user_change_role_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_event.dart';
import '../../../../blocs/checklist/systemUser/scheduleDates/sys_user_schedule_dates_states.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_bloc.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_events.dart';
import '../../../../blocs/checklist/systemUser/scheduleDatesResponse/schedule_dates_response_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_dimensions.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/error_section.dart';
import '../sys_user_workforce_list_screen.dart';

class ScheduleDatesSection extends StatelessWidget {
  final String checklistId;

  const ScheduleDatesSection({Key? key, required this.checklistId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleDatesBloc, ScheduleDatesStates>(
        builder: (context, state) {
      if (state is FetchingScheduleDates) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DatesScheduled) {
        return BlocListener<ScheduleDatesResponseBloc,
                ScheduleDatesResponseStates>(
            listener: (context, state) {
              if (state is NoResponseFound) {
                showCustomSnackBar(context, 'No response found!', '');
              } else if (state is FetchingWorkforceList) {
                Navigator.pushNamed(context, WorkForceListScreen.routeName);
              }
            },
            child: Padding(
                padding: const EdgeInsets.only(
                    left: leftRightMargin,
                    right: leftRightMargin,
                    top: topBottomPadding,
                    bottom: topBottomPadding),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        state.checklistScheduledByDatesModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: xxTinierSpacing,
                                      bottom: xxTinierSpacing),
                                  child: Row(children: [
                                    Image.asset("assets/icons/calendar.png",
                                        height: kProfileImageHeight,
                                        width: kProfileImageWidth),
                                    const SizedBox(width: tiniest),
                                    Text(
                                        state.checklistScheduledByDatesModel
                                            .data![index].dates,
                                        style:
                                            Theme.of(context).textTheme.xSmall)
                                  ])),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${state.checklistScheduledByDatesModel.data![index].responsecount} response out of ${state.checklistScheduledByDatesModel.data![index].totalworkforcecount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .xxSmall
                                            .copyWith(color: AppColor.grey)),
                                    const SizedBox(height: tiniest),
                                    Visibility(
                                        visible: state
                                                .checklistScheduledByDatesModel
                                                .data![index]
                                                .approvalpendingcount !=
                                            0,
                                        child: const Icon(
                                            Icons.question_mark_outlined,
                                            color: AppColor.errorRed,
                                            size: kIconSize)),
                                    const SizedBox(height: tiniest),
                                  ]),
                              onTap: () {
                                context.read<ScheduleDatesResponseBloc>().add(
                                    CheckScheduleDatesResponse(
                                        getChecklistDetailsData: state
                                            .checklistScheduledByDatesModel
                                            .data![index],
                                        scheduleId: state
                                            .checklistScheduledByDatesModel
                                            .data![index]
                                            .id,
                                        role: context
                                            .read<CheckListRoleBloc>()
                                            .roleId));
                              }));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: xxTinySpacing);
                    })));
      } else if (state is DatesNotScheduled) {
        return GenericReloadButton(
            onPressed: () => context
                .read<ScheduleDatesBloc>()
                .add(FetchScheduleDatesList(checklistId: checklistId)),
            textValue: StringConstants.kReload);
      } else {
        return const SizedBox();
      }
    });
  }
}
