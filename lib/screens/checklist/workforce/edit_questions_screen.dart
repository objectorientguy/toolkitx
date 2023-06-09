import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/checklist/widgets/checklist_app_bar.dart';
import 'package:toolkit/screens/checklist/workforce/questions_list_screen.dart';
import 'package:toolkit/screens/checklist/workforce/widgets/radio_button_list_expansion_tile.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/widgets/android_pop_up.dart';
import 'package:toolkit/widgets/custom_snackbar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/generic_text_field.dart';
import '../../../widgets/progress_bar.dart';
import '../../../widgets/upload_alert_dialog.dart';
import 'widgets/drop_down_expansion_tile.dart';
import 'widgets/multi_select_expansion_tile.dart';

class EditQuestionsScreen extends StatelessWidget {
  static const routeName = 'EditQuestionsScreen';

  const EditQuestionsScreen({Key? key}) : super(key: key);

  Widget fetchSwitchCaseWidget(
      type, index, answerModelList, answerList, context) {
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
              log("text 1======>${answerList[index]["answer"]}");
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              answerList[index]["answer"] = textValue;
              log("text 2======>${answerList[index]["answer"]}");
            });
      case 3:
        return DropDownExpansionTile(
          onValueChanged: (String dropDownId, String dropDownString) {
            answerList[index]["answer"] = dropDownId;
            log("ans=======>${answerList[index]["answer"]}");
          },
          answerModelList: answerModelList,
          index: index,
          value: '',
        );
      case 4:
        return RadioButtonExpansionTile(
            answerModelList: answerModelList,
            index: index,
            onRadioButtonChecked: (String radioId, String radioValue) {
              answerList[index]["answer"] = radioId;
            });
      case 5:
        return BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
            buildWhen: (previousState, currentState) =>
                currentState is QuestionsEdited,
            builder: (context, state) {
              if (state is QuestionsEdited) {
                answerList[index]["answer"] = state.multiSelectId
                    .toString()
                    .replaceAll("[", "")
                    .replaceAll("]", "");
                log("select====>${answerList[index]["answer"]}");
                return MultiSelectExpansionTile(
                    answerModelList: answerModelList,
                    index: index,
                    selectedIdList: state.multiSelectId,
                    selectedNamesList: state.multiSelectNames);
              } else {
                return const SizedBox();
              }
            });
      case 6:
        return SecondaryButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return UploadAlertDialog(onCamera: () {}, onDevice: () {});
                  });
            },
            textValue: StringConstants.kUpload);
      case 7:
        return TextFieldWidget(
            textInputType: TextInputType.number,
            value: answerList[index]["answer"],
            onTextFieldChanged: (String textValue) {
              log("text 7======>${answerList[index]["answer"]}");
              answerList[index]["answer"] = textValue;
            });
      case 8:
        return const TextField();
      case 10:
        return DatePickerTextField(
            hintText: StringConstants.kSelectDate,
            editDate: answerList[index]["answer"],
            onDatePicked: (String pickDate) {
              answerList[index]["answer"] = pickDate;
              log("date picked======>${answerList[index]["answer"]}");
            });
      case 11:
        return TimePickerTextField(
          editTime: answerList[index]["answer"],
          hintText: StringConstants.kSelectTime,
          onTimePicked: (String timePicked) {
            answerList[index]["answer"] = timePicked;
            log("time picked======>${answerList[index]["answer"]}");
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<WorkforceChecklistBloc>().add(
        EditQuestionData(questionList: [], multiSelect: '', dropDownValue: ''));
    return Scaffold(
        appBar: ChecklistAppBar(
          title: BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
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
        body: BlocConsumer<WorkforceChecklistBloc, WorkforceChecklistStates>(
            buildWhen: (previousState, currentState) =>
                currentState is SavedQuestions,
            listener: (context, state) {
              if (state is SubmittingQuestion) {
                ProgressBar.show(context);
              } else if (state is QuestionSubmitted) {
                ProgressBar.dismiss(context);
                Navigator.pushReplacementNamed(
                    context, WorkForceQuestionsList.routeName);
              } else if (state is QuestionNotSubmitted) {
                ProgressBar.dismiss(context);
                showCustomSnackBar(context, state.message, StringConstants.kOk);
              }
            },
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
                                            fetchSwitchCaseWidget(
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
                                                        context
                                                            .read<
                                                                WorkforceChecklistBloc>()
                                                            .add(FetchQuestionComment(
                                                            questionResponseId:
                                                            state.allChecklistDataMap[
                                                            "questionResponseId"]));
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
                        Row(children: [
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
                                                  .read<
                                                      WorkforceChecklistBloc>()
                                                  .add(SubmitQuestions(
                                                      editQuestionsList:
                                                          state.answersList,
                                                      isDraft: false));
                                            });
                                      });
                                },
                                textValue: StringConstants.kSubmit),
                          ),
                          const SizedBox(width: xxTinySpacing),
                          Expanded(
                              child: PrimaryButton(
                                  onPressed: () {
                                    context.read<WorkforceChecklistBloc>().add(
                                        SubmitQuestions(
                                            editQuestionsList:
                                                state.answersList,
                                            isDraft: true));
                                  },
                                  textValue: StringConstants.kSaveDraft))
                        ])
                      ]),
                    ));
              } else {
                return const SizedBox();
              }
            }));
  }
}
