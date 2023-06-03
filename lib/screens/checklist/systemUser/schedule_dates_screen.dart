import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/workforce_list_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/checklist/systemUser/checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checklist_events.dart';
import '../../../blocs/checklist/systemUser/checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../widgets/custom_snackbar.dart';

import '../../onboarding/widgets/custom_card.dart';

class SystemUserScheduleDatesScreen extends StatelessWidget {
  static const routeName = 'SystemUserScheduleDatesScreen';
  String? scheduleId;

  SystemUserScheduleDatesScreen({Key? key, this.scheduleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChecklistBloc, ChecklistStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ChecklistDatesScheduled,
        listener: (context, state) {
          if (state is ResponseChecked) {
            showCustomSnackBar(
                context, StringConstants.kNoResponse, StringConstants.kOk);
          } else if (state is FetchingChecklistWorkforceList) {
            ProgressBar.show(context);
          } else if (state is ChecklistWorkforceListFetched) {
            ProgressBar.dismiss(context);
            Navigator.pushNamed(context, ChecklistWorkForceListScreen.routeName,
                arguments: scheduleId);
          }
        },
        builder: (context, state) {
          if (state is ChecklistDatesScheduled) {
            return Scaffold(
                appBar: GenericAppBar(
                    title: BlocBuilder<ChecklistBloc, ChecklistStates>(
                        buildWhen: (previousState, currentState) =>
                            currentState is ChecklistDatesScheduled,
                        builder: (context, state) {
                          if (state is ChecklistDatesScheduled) {
                            return Text(state.getChecklistDetailsModel.data![0]
                                .checklistname);
                          } else {
                            return const SizedBox();
                          }
                        })),
                body: Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomSpacing,
                        bottom: topBottomSpacing),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.getChecklistDetailsModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: midTiniestSpacing,
                                        bottom: midTiniestSpacing),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/icons/calendar.png",
                                            height: kProfileImageHeight,
                                            width: kProfileImageWidth),
                                        const SizedBox(width: tiniestSpacing),
                                        Text(
                                            state.getChecklistDetailsModel
                                                .data![index].dates,
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall),
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${state.getChecklistDetailsModel.data![index].responsecount} response out of ${state.getChecklistDetailsModel.data![index].totalworkforcecount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xxSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(height: tiniestSpacing),
                                      Visibility(
                                          visible: state
                                                  .getChecklistDetailsModel
                                                  .data![index]
                                                  .approvalpendingcount !=
                                              0,
                                          child: const Icon(
                                              Icons.question_mark_outlined,
                                              color: AppColor.errorRed,
                                              size: kIconSize)),
                                      const SizedBox(height: tiniestSpacing),
                                    ],
                                  ),
                                  onTap: () {
                                    context.read<ChecklistBloc>().add(
                                        CheckResponse(
                                            scheduleId:
                                                state.getChecklistDetailsModel
                                                    .data![index].id,
                                            getChecklistDetailsData: state
                                                .getChecklistDetailsModel
                                                .data![index]));
                                    scheduleId = state.getChecklistDetailsModel
                                        .data![index].id;
                                  }));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinySpacing);
                        })));
          } else if (state is ChecklistScheduleDatesError) {
            return ShowError(onPressed: () {});
          } else {
            return const SizedBox();
          }
        });
  }
}