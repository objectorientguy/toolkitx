import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_states.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/screens/incident/widgets/date_picker.dart';
import 'package:toolkit/screens/incident/widgets/time_picker.dart';
import 'package:toolkit/screens/onboarding/widgets/text_field.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import 'package:toolkit/widgets/primary_button.dart';
import 'package:toolkit/widgets/secondary_button.dart';
import '../../../blocs/checklist/workforce/checklist_events.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/custom_card.dart';
import 'widgets/drop_down_expansion_tile.dart';
import 'widgets/multi_select_expansion_tile.dart';

class EditQuestionsScreen extends StatelessWidget {
  static const routeName = 'EditQuestionsScreen';

  EditQuestionsScreen({Key? key}) : super(key: key);
  final List editQuestionIdList = [];

  Widget fetchSwitchCaseWidget(
      type, index, answer, answerModelList, updateAnswers) {
    editQuestionIdList.add({
      "questionid": answer[index]["id"],
      "answer": updateAnswers[index]["answer"]
    });
    log("id=====>${answer[index]["id"]}");
    log("answerrr=====>${answer[index]["answer"]}");
    log("list edit screen=====>$editQuestionIdList");
    switch (type) {
      case 1:
        return TextFieldWidget(
            maxLines: 1,
            value: answer[index]["answer"],
            onTextFieldValueChanged: (String textValue) {
              answer[index] = textValue;
            });
      case 2:
        return TextFieldWidget(
            maxLines: 4,
            value: answer[index]["answer"],
            onTextFieldValueChanged: (String textValue) {
              answer[index]["answer"] = textValue;
            });
      case 3:
        return DropDownExpansionTile(
            onValueChanged: (String dropDownInt, String dropDownString) {
              editQuestionIdList[index]["questionid"] = dropDownInt;
              editQuestionIdList[index]["answer"] = dropDownString;
              log("this is id======>${editQuestionIdList[index]["questionid"]}");
              log("this is answer======>${editQuestionIdList[index]["answer"]}");
            },
            answerModelList: answerModelList,
            value: answer[index]["answer"],
            index: index,
            editQuestionIdList: editQuestionIdList,
            answerList: answer);
      case 4:
        return TextFieldWidget();
      case 5:
        return MultiSelectExpansionTile(
          onCheckBoxChecked: (String checkbox) {},
          answerModelList: answerModelList,
        );
      case 7:
        return TextFieldWidget(
            value: answer[index]["answer"],
            maxLines: 5,
            onTextFieldValueChanged: (String textValue) {
              answer[index]["answer"] = textValue;
              log("this is 7======>${answer[index]["answer"]}");
            });
      case 8:
        return const TextField();
      case 10:
        return DatePickerTextField(
          hintText: StringConstants.kSelectDate,
        );
      case 11:
        return TimePickerTextField(
          hintText: StringConstants.kSelectTime,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<WorkforceChecklistBloc>().add(PopulateQuestion(
        populateQuestionsList: [],
        questionList: [],
        multiSelect: '',
        dropDownValue: ''));
    return Scaffold(
        appBar: GenericAppBar(
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
              } else if (state is QuestionsFetched) {
                ProgressBar.dismiss(context);
              } else if (state is QuestionsError) {}
            },
            builder: (context, state) {
              if (state is SavedQuestions) {
                return Padding(
                    padding: const EdgeInsets.only(
                        left: leftRightMargin,
                        right: leftRightMargin,
                        top: topBottomSpacing),
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
                                padding: const EdgeInsets.all(cardPadding),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.answerModelList[index].title
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .small
                                              .copyWith(
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.w500)),
                                      const SizedBox(height: tiniestSpacing),
                                      fetchSwitchCaseWidget(
                                          state.answerModelList[index].type,
                                          index,
                                          state.populateAnswerList,
                                          state.answerModelList,
                                          state.updateAnswer),
                                      const SizedBox(height: tiniestSpacing),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SecondaryButton(
                                                onPressed: () {},
                                                textValue:
                                                    StringConstants.kAddImages),
                                            SecondaryButton(
                                                onPressed: () {},
                                                textValue:
                                                    StringConstants.kAddTodo)
                                          ]),
                                    ]),
                              ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: tinySpacing);
                            }),
                        const SizedBox(height: mediumSpacing),
                        Row(children: [
                          Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  context.read<WorkforceChecklistBloc>().add(
                                      SubmitQuestions(
                                          editQuestionsList: editQuestionIdList,
                                          submitQuestionsList:
                                              state.populateAnswerList));
                                },
                                textValue: StringConstants.kSubmit),
                          ),
                          const SizedBox(width: tinySpacing),
                          Expanded(
                              child: PrimaryButton(
                                  onPressed: () {},
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
