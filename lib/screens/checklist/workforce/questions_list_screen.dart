import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_states.dart';
import 'package:toolkit/screens/onboarding/widgets/show_error.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../../blocs/checklist/workforce/checklist_events.dart';
import '../../../widgets/progress_bar.dart';
import 'add_image_and_comment_screen.dart';
import 'widgets/pop_up_menu.dart';
import 'widgets/question_list_section.dart';

class WorkForceQuestionsList extends StatelessWidget {
  static const routeName = 'WorkForceQuestionsList';

  const WorkForceQuestionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(
            title:
                BlocBuilder<WorkforceChecklistBloc, WorkforceChecklistStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is QuestionsFetched,
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
                      currentState is QuestionsFetched,
                  builder: (context, state) {
                    if (state is QuestionsFetched) {
                      return Visibility(
                          visible:
                              state.allChecklistDataMap["isRejected"] != "0",
                          child: const WorkForcePopUpMenu());
                    } else {
                      return const SizedBox();
                    }
                  })
            ]),
        body: BlocConsumer<WorkforceChecklistBloc, WorkforceChecklistStates>(
            buildWhen: (previousState, currentState) =>
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
              if (state is QuestionsFetched) {
                return QuestionsListSection(
                    getQuestionListModel: state.getQuestionListModel,
                    answerList: state.answerList);
              } else if (state is QuestionsError) {
                return ShowError(onPressed: () {
                  context.read<WorkforceChecklistBloc>().add(
                      FetchQuestions(checklistData: state.allChecklistDataMap));
                });
              } else {
                return const SizedBox();
              }
            }));
  }
}
