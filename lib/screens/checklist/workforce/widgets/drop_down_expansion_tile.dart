import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/configs/app_spacing.dart';

import '../../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/questions_list_model.dart';

typedef DropDownCallBack = Function(String dropDownId, String dropDownString);

class DropDownExpansionTile extends StatelessWidget {
  final String value;
  final DropDownCallBack onValueChanged;
  final List<Questionlist> answerModelList;
  final int index;

  const DropDownExpansionTile(
      {Key? key,
      required this.onValueChanged,
      required this.answerModelList,
      required this.value,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropDown = '';
    String dropDownId = '';
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
                    collapsedBackgroundColor: AppColor.offWhite,
                    tilePadding: const EdgeInsets.only(
                        left: xxTinierSpacing, right: xxTinierSpacing),
                    iconColor: AppColor.deepBlue,
                    textColor: AppColor.black,
                    title: Text((dropDown == "") ? 'Select' : dropDown),
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
                                    contentPadding:
                                        const EdgeInsets.only(left: tiniest),
                                    title: Text(answerModelList[index]
                                            .queoptions![listIndex]
                                        ["queoptiontext"]),
                                    onTap: () {
                                      dropDown = answerModelList[index]
                                          .queoptions![listIndex]
                                              ["queoptiontext"]
                                          .toString();
                                      dropDownId = answerModelList[index]
                                          .queoptions![listIndex]["queoptionid"]
                                          .toString();
                                      onValueChanged(
                                          dropDownId.toString(), dropDown);
                                      context
                                          .read<WorkforceChecklistBloc>()
                                          .add(EditQuestions(
                                              dropDownValue: dropDown,
                                              multiSelectIdList: [],
                                              multiSelectItem: '',
                                              multiSelectName: '',
                                              multiSelectNameList: []));
                                    });
                              }))
                    ]));
          } else {
            return const SizedBox();
          }
        });
  }
}
