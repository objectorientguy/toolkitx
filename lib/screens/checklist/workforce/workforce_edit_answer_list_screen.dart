import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/editAnswer/workforce_edit_answer_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/checklist_app_bar.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/workforce/editAnswer/workforce_edit_answer_events.dart';
import '../../../blocs/workforce/editAnswer/workforce_edit_answer_states.dart';
import '../../../blocs/workforce/getQuestionsList/get_questions_list_bloc.dart';
import '../../../blocs/workforce/submitAnswers/workforce_submit_answer_bloc.dart';
import '../../../blocs/workforce/submitAnswers/workforce_submit_answer_events.dart';
import '../../../blocs/workforce/submitAnswers/workforce_submit_answer_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/edit_answer_util.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/progress_bar.dart';

class EditAnswerListScreen extends StatelessWidget {
  static const routeName = 'EditAnswerListScreen';

  const EditAnswerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EditAnswerBloc>().add(PopulateAnswerData(
        questionList: context.read<WorkForceQuestionsListBloc>().questionList!,
        multiSelect: '',
        dropDownValue: '',
        answerList: context.read<WorkForceQuestionsListBloc>().answerList,
        allChecklistDataMap:
            context.read<WorkForceQuestionsListBloc>().allDataForChecklistMap));
    return Scaffold(
        appBar: ChecklistAppBar(
          title: BlocBuilder<EditAnswerBloc, EditAnswerStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is SavedQuestions,
              builder: (context, state) {
                if (state is SavedQuestions) {
                  return Text(state.allChecklistDataMap["name"]);
                } else {
                  return const SizedBox();
                }
              }),
        ),
        body: BlocBuilder<EditAnswerBloc, EditAnswerStates>(
            buildWhen: (previousState, currentState) =>
                currentState is SavedQuestions,
            builder: (context, state) {
              if (state is SavedQuestions) {
                log("stateee=====>${state.answersList}");
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomPadding),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.answerModelList.length,
                            itemBuilder: (context, index) {
                              return CustomCard(
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.all(kCardPadding),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                state.answerModelList[index]
                                                    .title
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .small
                                                    .copyWith(
                                                        color: AppColor.black,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            const SizedBox(height: tiniest),
                                            EditAnswerUtil()
                                                .fetchSwitchCaseWidget(
                                                    state.answerModelList[index]
                                                        .type,
                                                    index,
                                                    state.answerModelList,
                                                    state.answersList,
                                                    context),
                                            const SizedBox(
                                                height: xxTinierSpacing),
                                            Visibility(
                                              visible: state
                                                      .answerModelList[index]
                                                      .title ==
                                                  "Abdampftemperatur",
                                              child: Text(
                                                  'Please enter your answer between ${state.answerModelList[index].minval} bis ${state.answerModelList[index].maxval}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .xSmall
                                                      .copyWith(
                                                          color:
                                                              AppColor.errorRed,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            ),
                                            const SizedBox(height: tiniest),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SecondaryButton(
                                                      onPressed: () {
                                                        // context
                                                        //     .read<
                                                        //     WorkforceChecklistBloc>()
                                                        //     .add(FetchQuestionComment(
                                                        //     questionResponseId:
                                                        //     state.allChecklistDataMap[
                                                        //     "questionResponseId"]));
                                                      },
                                                      textValue: StringConstants
                                                          .kAddImages),
                                                  SecondaryButton(
                                                      onPressed: () {},
                                                      textValue: StringConstants
                                                          .kAddTodo)
                                                ])
                                          ])));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: xxTinySpacing);
                            }),
                        const SizedBox(height: xxxSmallerSpacing),
                        BlocListener<SubmitAnswerBloc, SubmitAnswerStates>(
                          listener: (context, state) {
                            if (state is SubmittingAnswer) {
                              ProgressBar.show(context);
                            } else if (state is AnswerSubmitted) {
                              ProgressBar.dismiss(context);
                              Navigator.pop(context);
                              // Navigator.pushReplacementNamed(
                              //     context, WorkForceQuestionsList.routeName);
                            } else if (state is AnswerNotSubmitted) {
                              ProgressBar.dismiss(context);
                              showCustomSnackBar(
                                  context, state.message, StringConstants.kOk);
                            }
                          },
                          child: Row(children: [
                            Expanded(
                              child: PrimaryButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AndroidPopUp(
                                              titleValue:
                                                  StringConstants.kChecklist,
                                              contentValue:
                                                  'After submitting you will not be able to edit the checklist again.',
                                              onPressed: () {
                                                context
                                                    .read<SubmitAnswerBloc>()
                                                    .add(SubmitAnswers(
                                                        editQuestionsList:
                                                            state.answersList,
                                                        isDraft: false,
                                                        allChecklistDataMap: context
                                                            .read<
                                                                WorkForceQuestionsListBloc>()
                                                            .allDataForChecklistMap));
                                              });
                                        });
                                  },
                                  textValue: StringConstants.kSubmit),
                            ),
                            const SizedBox(width: xxTinySpacing),
                            Expanded(
                                child: PrimaryButton(
                                    onPressed: () {
                                      context.read<SubmitAnswerBloc>().add(
                                          SubmitAnswers(
                                              editQuestionsList:
                                                  state.answersList,
                                              isDraft: false,
                                              allChecklistDataMap: context
                                                  .read<EditAnswerBloc>()
                                                  .allDataForChecklistMap));
                                    },
                                    textValue: StringConstants.kSaveDraft))
                          ]),
                        )
                      ]),
                    ));
              } else {
                return const SizedBox();
              }
            }));
  }
}
