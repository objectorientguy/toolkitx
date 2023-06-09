import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/checklist/workforce/workforce_checklist_bloc.dart';
import '../../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../data/models/checklist/workforce/questions_list_model.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/secondary_button.dart';
import '../../../onboarding/widgets/custom_card.dart';

class QuestionsListSection extends StatelessWidget {
  final GetQuestionListModel getQuestionListModel;
  final List answerList;

  const QuestionsListSection({Key? key, required this.getQuestionListModel, required this.answerList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: topBottomPadding),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: getQuestionListModel.data!.questionlist!.length,
        itemBuilder: (context, index) {
          log("answer listtttt=====>$answerList");
          return CustomCard(
              child: Padding(
            padding: const EdgeInsets.all(kCardPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                        '${getQuestionListModel.data!.questionlist![index].title}?',
                        style: Theme.of(context).textTheme.small.copyWith(
                                color: AppColor.black, fontWeight: FontWeight.w500),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                  ),
                  Visibility(
                    visible: getQuestionListModel
                            .data!.questionlist![index].moreinfo !=
                        null,
                    child: Text(
                        'Hint: ${getQuestionListModel.data!.questionlist![index].moreinfo}'),
                  )
                ],
              ),
              const SizedBox(height: tiniest),
              Text(
                  (answerList[index]["answer"].toString() == 'null'
                      ? ''
                      : answerList[index]["answer"].toString()),
                  style: Theme.of(context)
                      .textTheme
                      .small
                      .copyWith(color: AppColor.black)),
              const SizedBox(height: tiniest),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: SecondaryButton(
                        onPressed: () {
                          context
                              .read<WorkforceChecklistBloc>()
                              .add(FetchQuestionComment(
                                questionResponseId: getQuestionListModel
                                    .data!.questionlist![index].queresponseid
                                    .toString(),
                              ));
                        },
                        textValue: StringConstants.kAddImages)),
                const SizedBox(width: tiniest),
                Expanded(
                  child: SecondaryButton(
                      onPressed: () {}, textValue: StringConstants.kAddTodo),
                )
              ]),
                ]),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: xxTinySpacing);
        });
  }
}
