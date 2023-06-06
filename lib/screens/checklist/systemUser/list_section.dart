import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/checklist/systemUser/system_user_list_model.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_events.dart';
import '../../../blocs/checklist/systemUser/system_user_checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/custom_card.dart';
import '../widgets/custom_visibility_tags_container.dart';
import 'schedule_dates_screen.dart';

class SystemUserListSection extends StatelessWidget {
  SystemUserListSection({Key? key}) : super(key: key);
  final List<GetChecklistData> data = [];
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ChecklistBloc, ChecklistStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ChecklistFetched ||
                  currentState is ChecklistError,
              listener: (context, state) {
                if (state is FetchingChecklistScheduleDates) {
                  ProgressBar.show(context);
                } else if (state is ChecklistDatesScheduled) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(
                      context, SystemUserScheduleDatesScreen.routeName);
                } else if (state is ChecklistFetching) {
                  showCustomSnackBar(context, 'Loading data', 'Ok');
                } else if (state is ChecklistFetched &&
                    state.getChecklistModel.data!.isEmpty) {
                  showCustomSnackBar(context, 'No more data!', 'Ok');
                  context.read<ChecklistBloc>().isFetching = false;
                } else if (state is ChecklistError) {
                  context.read<ChecklistBloc>().isFetching = false;
                  showCustomSnackBar(context, 'Something went wrong!', 'Ok');
                }
              },
              builder: (context, state) {
                if (state is ChecklistInitial ||
                    state is ChecklistFetching && data.isEmpty) {
                  return const CircularProgressIndicator();
                } else if (state is ChecklistFetched) {
                  data.addAll(state.getChecklistModel.data!);
                  context.read<ChecklistBloc>().isFetching = false;
                } else if (state is ChecklistError && data.isEmpty) {
                  return ShowError(onPressed: () {
                    context.read<ChecklistBloc>().add(FetchChecklist());
                  });
                } else {
                  return const SizedBox();
                }
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        controller: scrollController
                          ..addListener(() {
                            if (scrollController.offset ==
                                    scrollController.position.maxScrollExtent &&
                                !context.read<ChecklistBloc>().isFetching) {
                              context.read<ChecklistBloc>()
                                ..isFetching = true
                                ..add(FetchChecklist());
                            }
                          }),
                        itemBuilder: (context, index) {
                          return CustomCard(
                              child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.all(midTinySpacing),
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: midTiniestSpacing),
                                    child: Text(data[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(color: AppColor.black)),
                                  ),
                                  subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${data[index].categoryname} -- ${data[index].subcategoryname.toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .xSmall
                                                .copyWith(
                                                    color: AppColor.grey)),
                                        const SizedBox(height: tinySpacing),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible:
                                                    data[index].responsecount !=
                                                        0,
                                                child: const CustomTagContainer(
                                                    color: AppColor.lightGreen,
                                                    textValue: StringConstants
                                                        .kResponded),
                                              ),
                                              const SizedBox(
                                                  width: tiniestSpacing),
                                              // Visibility(
                                              //   visible: data[index].overduecount != 0,
                                              //   child: const CustomTagContainer(
                                              //     color: AppColor.yellow,
                                              //     textValue: 'Overdue')),
                                              // const SizedBox(
                                              //     width: tiniestSpacing),
                                              Visibility(
                                                  visible: data[index]
                                                          .approvalpendingcount !=
                                                      0,
                                                  child: const Icon(
                                                      Icons
                                                          .question_mark_outlined,
                                                      color: AppColor.errorRed,
                                                      size: kIconSize))
                                            ])
                                      ]),
                                  onTap: () {
                                    context.read<ChecklistBloc>().add(
                                        FetchChecklistScheduleDates(
                                            checklistId: data[index].id,
                                            allChecklistDataMap: {}));
                                  }));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: tinySpacing);
                        }));
              }),
        ],
      ),
    );
  }
}
