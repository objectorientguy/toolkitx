import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../blocs/workforce/getQuestionsList/get_questions_list_bloc.dart';
import '../../../../blocs/workforce/getQuestionsList/get_questions_list_events.dart';
import '../../../../blocs/workforce/getQuestionsList/get_questions_list_states.dart';
import '../../../../configs/app_color.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/error_section.dart';
import '../../../../widgets/secondary_button.dart';
import '../add_image_and_comments_screen.dart';

class QuestionsListSection extends StatelessWidget {
  const QuestionsListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkForceQuestionsListBloc, WorkForceQuestionsStates>(
        builder: (context, state) {
      if (state is FetchingQuestionsList) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is QuestionsListFetched) {
        return ListView.separated(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: topBottomPadding),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.getQuestionListModel.data!.questionlist!.length,
            itemBuilder: (context, index) {
              log("answer listtttt=====>${state.answerList}");
              return CustomCard(
                  child: Padding(
                padding: const EdgeInsets.all(kCardPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                                '${state.getQuestionListModel.data!.questionlist![index].title}?',
                                style: Theme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Visibility(
                            visible: state.getQuestionListModel.data!
                                    .questionlist![index].moreinfo !=
                                null,
                            child: Text(
                                'Hint: ${state.getQuestionListModel.data!.questionlist![index].moreinfo}'),
                          )
                        ],
                      ),
                      const SizedBox(height: tiniest),
                      Text(
                          (state.answerList[index]["answer"].toString() ==
                                      'null' ||
                                  state.answerList[index]["answer"]
                                          .toString() ==
                                      "")
                              ? ''
                              : state.answerList[index]["answer"].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .small
                              .copyWith(color: AppColor.black)),
                      const SizedBox(height: tiniest),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: SecondaryButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          AddImageAndCommentScreen.routeName,
                                          arguments: state
                                              .getQuestionListModel
                                              .data!
                                              .questionlist![index]
                                              .queresponseid
                                              .toString());
                                    },
                                    textValue: StringConstants.kAddImages)),
                            const SizedBox(width: tiniest),
                            Expanded(
                              child: SecondaryButton(
                                  onPressed: () {},
                                  textValue: StringConstants.kAddTodo),
                            )
                          ]),
                    ]),
              ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: xxTinySpacing);
            });
      } else if (state is QuestionsListNotFetched) {
        return GenericReloadButton(
            onPressed: () {
              context.read<WorkForceQuestionsListBloc>().add(
                  FetchQuestions(checklistData: state.allChecklistDataMap));
            },
            textValue: StringConstants.kReload);
      } else {
        return const SizedBox();
      }
    });
  }
}
