import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_bloc.dart';
import '../../../../blocs/checklist/workforce/editAnswer/workforce_checklist_edit_answer_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';
import '../../../../utils/database_utils.dart';

typedef CheckBoxCallBack = Function(String checkboxId, String checkboxValue);

class MultiSelectExpansionTile extends StatelessWidget {
  final List<Questionlist> answerModelList;
  final int index;
  final List selectedIdList;
  final List selectedNamesList;

  const MultiSelectExpansionTile(
      {Key? key,
      required this.answerModelList,
      required this.index,
      required this.selectedIdList,
      required this.selectedNamesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String multiSelectNames =
        selectedNamesList.toString().replaceAll("[", "").replaceAll("]", "");
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: kExpansionTileMargin, right: kExpansionTileMargin),
            collapsedBackgroundColor: AppColor.offWhite,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            title: Text(
                (multiSelectNames == "")
                    ? DatabaseUtil.getText('select_item')
                    : multiSelectNames,
                style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: answerModelList[index].queoptions!.length,
                  itemBuilder: (BuildContext context, int listIndex) {
                    return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: selectedIdList.contains(answerModelList[index]
                            .queoptions![listIndex]["queoptionid"]
                            .toString()),
                        title: Text(answerModelList[index]
                            .queoptions![listIndex]["queoptiontext"]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          context.read<WorkForceCheckListEditAnswerBloc>().add(
                              CheckListEditAnswerEvent(
                                  multiSelectIdList: selectedIdList,
                                  multiSelectItem: answerModelList[index]
                                      .queoptions![listIndex]["queoptionid"]
                                      .toString(),
                                  multiSelectName: answerModelList[index]
                                      .queoptions![listIndex]["queoptiontext"],
                                  multiSelectNameList: selectedNamesList));
                        });
                  })
            ]));
  }
}
