import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_events.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/workforce/questions_list_model.dart';

typedef CheckBoxCallBack = Function(String checkbox);

class MultiSelectExpansionTile extends StatelessWidget {
  final CheckBoxCallBack onCheckBoxChecked;
  final List<Questionlist> answerModelList;

  const MultiSelectExpansionTile(
      {Key? key,
      required this.onCheckBoxChecked,
      required this.answerModelList})
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
                  itemCount: answerModelList[0].queoptions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      value: false,
                      title: const Text(''),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) {
                        context.read<WorkforceChecklistBloc>().add(
                            PopulateQuestion(
                                multiSelect: '',
                                questionList: answerModelList,
                                populateQuestionsList: [],
                                dropDownValue: null));
                      },
                    );
                  })
            ]));
  }
}
