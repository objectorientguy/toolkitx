import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../blocs/systemUser/checklist/checklist_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../blocs/systemUser/checklist/checklist_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/custom_card.dart';
import '../../onboarding/widgets/show_error.dart';
import 'details_screen.dart';

class ChecklistListSection extends StatelessWidget {
  const ChecklistListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChecklistBloc, ChecklistStates>(
        buildWhen: (previousState, currentState) =>
            currentState is ChecklistFetching ||
            currentState is ChecklistFetched,
        listener: (context, state) {
          if (state is ChecklistDetailsFetching) {
            ProgressBar.show(context);
          } else if (state is ChecklistDetailsFetched) {
            ProgressBar.dismiss(context);
            Navigator.pushNamed(context, DetailsScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state is ChecklistFetching) {
            return const CircularProgressIndicator();
          } else if (state is ChecklistFetched) {
            return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.getChecklistModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(midTinySpacing),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: midTiniestSpacing),
                                child: Text(
                                    state.getChecklistModel.data![index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(color: AppColor.black)),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                          '${state.getChecklistModel.data![index].categoryname}  --',
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey)),
                                      const SizedBox(width: tiniestSpacing),
                                      Text(
                                          state.getChecklistModel.data![index]
                                              .subcategoryname
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .xSmall
                                              .copyWith(color: AppColor.grey))
                                    ]),
                                    const SizedBox(height: tinySpacing),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: state
                                                    .getChecklistModel
                                                    .data![index]
                                                    .responsecount !=
                                                0,
                                            child: Container(
                                                padding: const EdgeInsets.all(
                                                    tiniestSpacing),
                                                decoration: BoxDecoration(
                                                    color: AppColor.lightGreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kCardRadius)),
                                                height: kTagsHeight,
                                                child: Text(
                                                    StringConstants.kResponded,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .xSmall
                                                        .copyWith(
                                                            color: AppColor
                                                                .white))),
                                          ),
                                          const SizedBox(width: tiniestSpacing),
                                          Visibility(
                                              visible: state
                                                      .getChecklistModel
                                                      .data![index]
                                                      .approvalpendingcount !=
                                                  0,
                                              child: const Icon(
                                                  Icons.question_mark_outlined,
                                                  color: AppColor.errorRed,
                                                  size: kIconSize))
                                        ])
                                  ]),
                              onTap: () {
                                context.read<ChecklistBloc>().add(
                                    FetchChecklistDetails(
                                        checklistId: state.getChecklistModel
                                            .data![index].id));
                              }));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: tinySpacing);
                    }));
          } else if (state is ChecklistError) {
            return ShowError(onPressed: () {});
          } else {
            return const SizedBox();
          }
        });
  }
}
