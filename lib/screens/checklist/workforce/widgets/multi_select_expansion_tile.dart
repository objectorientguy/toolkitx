import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/workforce/questions_list_model.dart';

typedef CheckBoxCallBack = Function(String checkboxId, String checkboxValue);

class MultiSelectExpansionTile extends StatelessWidget {
  final List<Questionlist> answerModelList;
  final int index;
  final List selectedItems;

  const MultiSelectExpansionTile(
      {Key? key,
      required this.answerModelList,
      required this.index,
      required this.selectedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: const EdgeInsets.only(
                left: expansionTileMargin, right: expansionTileMargin),
            collapsedBackgroundColor: AppColor.offWhite,
            maintainState: true,
            iconColor: AppColor.deepBlue,
            textColor: AppColor.black,
            key: GlobalKey(),
            title: Text('', style: Theme.of(context).textTheme.xSmall),
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: answerModelList[index].queoptions!.length,
                  itemBuilder: (BuildContext context, int listIndex) {
                    return CheckboxListTile(
                        value: selectedItems.contains(answerModelList[index]
                            .queoptions![listIndex]["queoptionid"]
                            .toString()),
                        title: Text(answerModelList[index]
                            .queoptions![listIndex]["queoptiontext"]),
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (isChecked) {
                          String selectedId = answerModelList[index]
                              .queoptions![listIndex]["queoptionid"]
                              .toString();
                          context.read<WorkforceChecklistBloc>().add(
                              EditQuestions(
                                  multiSelectList: selectedItems,
                                  multiSelectItem: answerModelList[index]
                                      .queoptions![listIndex]["queoptionid"]
                                      .toString(),
                                  multiSelectName: answerModelList[index]
                                          .queoptions![listIndex]
                                      ["queoptiontext"]));
                          log("replace all=====>$selectedId");
                        });
                  })
            ]));
  }
}
