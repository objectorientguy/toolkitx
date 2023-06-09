import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/workforce_checklist_states.dart';
import 'package:toolkit/screens/checklist/widgets/checklist_app_bar.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/widgets/error_section.dart';
import '../../../blocs/checklist/workforce/workforce_checklist_events.dart';
import '../../../widgets/progress_bar.dart';
import 'add_image_and_comment_screen.dart';
import 'widgets/pop_up_menu.dart';
import 'widgets/question_list_section.dart';

class WorkForceQuestionsList extends StatelessWidget {
  static const routeName = 'WorkForceQuestionsList';
  final Map checklistDataMap;

  const WorkForceQuestionsList({Key? key, required this.checklistDataMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkforceChecklistBloc>()
        .add(FetchQuestions(checklistData: checklistDataMap));
    return Scaffold(
        appBar: ChecklistAppBar(
            title:
                BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is FetchingQuestions ||
                        currentState is QuestionsFetched ||
                        currentState is QuestionsError,
                    builder: (context, state) {
                      if (state is QuestionsFetched) {
                        state.allChecklistDataMap["name"] =
                            state.getQuestionListModel.data!.name.toString();
                        return Text(
                        state.getQuestionListModel.data!.name.toString());
                  } else {
                    return const SizedBox();
                  }
                }),
            actions: [
              BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
                  buildWhen: (previousState, currentState) =>
                      currentState is FetchingQuestions ||
                      currentState is QuestionsFetched ||
                      currentState is QuestionsFetched,
                  builder: (context, state) {
                    if (state is QuestionsFetched) {
                      return Visibility(
                          visible:
                          state.allChecklistDataMap["isRejected"] == "0",
                          child: const WorkForcePopUpMenu());
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        body: BlocConsumer<WorkforceChecklistBloc, WorkforceChecklistStates>(
            buildWhen: (previousState, currentState) =>
                currentState is FetchingQuestions ||
                currentState is QuestionsFetched ||
                currentState is QuestionsFetched,
            listener: (context, state) {
              if (state is FetchingQuestionComments) {
                ProgressBar.show(context);
              } else if (state is QuestionCommentsFetched) {
                ProgressBar.dismiss(context);
                Navigator.pushNamed(
                    context, AddImageAndCommentScreen.routeName);
              }
            },
            builder: (context, state) {
              if (state is FetchingQuestions) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is QuestionsFetched) {
                return QuestionsListSection(
                    getQuestionListModel: state.getQuestionListModel,
                    answerList: state.answerList);
              } else if (state is QuestionsError) {
                return GenericReloadButton(
                    onPressed: () {
                      context.read<WorkforceChecklistBloc>().add(FetchQuestions(
                          checklistData: state.allChecklistDataMap));
                    },
                    textValue: StringConstants.kReload);
              } else {
                return const SizedBox();
              }
            }));
  }
}
