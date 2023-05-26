import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_bloc.dart';
import 'package:toolkit/blocs/systemUser/checklist/checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/systemUser/status_screen.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/progree_bar.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../widgets/custom_snackbar.dart';

import '../../onboarding/widgets/custom_card.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'DetailsScreen';

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title:
            BlocBuilder<ChecklistBloc, ChecklistStates>(
                builder: (context, state) {
          if (state is ChecklistDetailsFetched) {
            return Text(state.getChecklistDetailsModel.data[0].checklistname);
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
            child: BlocConsumer<ChecklistBloc, ChecklistStates>(
                listener: (context, state) {
              if (state is ChecklistDetailsFetched) {
                if (state.isResponded == true) {
                  showCustomSnackBar(context, StringConstants.kNoResponse,
                      StringConstants.kOk);
                }
              } else if (state is ChecklistStatusFetching) {
                log("fetching status======>");
                ProgressBar.show(context);
              } else if (state is ChecklistStatusFetched) {
                log("fetched status======>");
                ProgressBar.dismiss(context);
                Navigator.pushNamed(context, ChecklistStatusScreen.routeName);
              }
            }, builder: (context, state) {
              if (state is ChecklistDetailsFetched) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.getChecklistDetailsModel.data.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: ListTile(
                              title: Text(
                                  state.getChecklistDetailsModel.data[index]
                                      .dates,
                                  style: Theme.of(context).textTheme.xSmall),
                              subtitle: Text(
                                  '${state.getChecklistDetailsModel.data[index].responsecount} response out of ${state.getChecklistDetailsModel.data[index].totalworkforcecount}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .xxSmall
                                      .copyWith(color: AppColor.grey)),
                              onTap: () {
                                context.read<ChecklistBloc>().add(
                                    NavigateToStatusScreen(
                                        scheduleId: state
                                            .getChecklistDetailsModel
                                            .data[index]
                                            .id,
                                        getChecklistDetailsData: state
                                            .getChecklistDetailsModel
                                            .data[index],
                                        getChecklistDetailsModel:
                                            state.getChecklistDetailsModel));
                              }));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: tinySpacing);
                    });
              } else if (state is ChecklistDetailsError) {
                return ShowError(onPressed: () {});
              } else {
                return const SizedBox();
              }
            })));
  }
}
