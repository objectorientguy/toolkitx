import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_bloc.dart';
import 'package:toolkit/blocs/checklist/workforce/checklist_states.dart';
import 'package:toolkit/widgets/progress_bar.dart';
import '../../../blocs/checklist/workforce/checklist_events.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/generic_app_bar.dart';
import '../../onboarding/widgets/show_error.dart';
import 'questions_list_screen.dart';
import 'widgets/list_section.dart';

class WorkForceListScreen extends StatelessWidget {
  static const routeName = 'WorkForceListScreen';

  const WorkForceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<WorkforceChecklistBloc>()
        .add(FetchChecklist(userId: 'W2mt1FgZTZTQWTIvm4wU1w=='));
    return Scaffold(
        appBar: const GenericAppBar(title: Text(StringConstants.kChecklist)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: midTiniestSpacing),
            child: BlocConsumer<WorkforceChecklistBloc,
                    WorkforceChecklistStates>(
                buildWhen: (previousState, currentState) =>
                    currentState is FetchingChecklist ||
                    currentState is ChecklistFetched ||
                    currentState is FetchChecklistError,
                listener: (context, state) {
                  if (state is FetchingQuestions) {
                    ProgressBar.show(context);
                  } else if (state is QuestionsFetched) {
                    ProgressBar.dismiss(context);
                    Navigator.pushNamed(
                        context, WorkForceQuestionsList.routeName);
                  }
                },
                builder: (context, state) {
                  if (state is FetchingChecklist) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChecklistFetched) {
                    return ListSection(
                        workforceGetCheckListModel: state.getCheckListModel);
                  } else if (state is FetchChecklistError) {
                    return ShowError(onPressed: () {
                      context.read<WorkforceChecklistBloc>().add(
                          FetchChecklist(userId: 'W2mt1FgZTZTQWTIvm4wU1w=='));
                    });
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
