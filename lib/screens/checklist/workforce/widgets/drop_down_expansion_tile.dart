import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_states.dart';

import '../../../../blocs/checklist/workforce/checklist_events.dart';
import '../../../../data/models/checklist/workforce/questions_list_model.dart';

typedef DropDownCallBack = Function(String dropDownInt, String dropDownString);

class DropDownExpansionTile extends StatelessWidget {
  final String value;
  final DropDownCallBack onValueChanged;
  final List<Questionlist> answerModelList;
  final int index;
  final List editQuestionIdList;
  final List answerList;

  const DropDownExpansionTile(
      {Key? key,
      required this.onValueChanged,
      required this.answerModelList,
      required this.value,
      required this.index,
      required this.editQuestionIdList,
      required this.answerList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropDownValue = '';
    log("editQuestionIdList====>${editQuestionIdList[index]["answer"]}");
    return BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
        buildWhen: (previousState, currentState) =>
            currentState is QuestionsEdited,
        builder: (context, state) {
          if (state is QuestionsEdited) {
            return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    key: GlobalKey(),
                    collapsedBackgroundColor: Colors.grey[100],
                    tilePadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.022),
                    iconColor: Colors.blue,
                    textColor: Colors.black,
                    title: Text((editQuestionIdList[index]["answer"] == null)
                        ? 'Select'
                        : editQuestionIdList[index]["answer"]),
                    children: [
                      MediaQuery(
                          data: MediaQuery.of(context)
                              .removePadding(removeTop: true),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  answerModelList[index].queoptions!.length,
                              itemBuilder: (context, listIndex) {
                                return ListTile(
                                    contentPadding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    title: Text(answerModelList[index]
                                            .queoptions![listIndex]
                                        ["queoptiontext"]),
                                    onTap: () {
                                      editQuestionIdList[index]["answer"] =
                                          answerModelList[index]
                                              .queoptions![listIndex]
                                                  ["queoptiontext"]
                                              .toString();
                                      onValueChanged(
                                          answerModelList[index]
                                              .queoptions![listIndex]
                                                  ["queoptionid"]
                                              .toString(),
                                          answerModelList[index]
                                                  .queoptions![listIndex]
                                              ["queoptiontext"]);
                                      context
                                          .read<WorkforceChecklistBloc>()
                                          .add(EditQuestions(
                                              editQuestionsList:
                                                  editQuestionIdList));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
