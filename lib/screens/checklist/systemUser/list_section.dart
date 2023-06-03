import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/checklist/systemUser/checklist_bloc.dart';
import '../../../blocs/checklist/systemUser/checklist_events.dart';
import '../../../blocs/checklist/systemUser/checklist_states.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/show_error.dart';
import '../widgets/list_layout.dart';
import 'schedule_dates_screen.dart';

class SystemUserListSection extends StatelessWidget {
  const SystemUserListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ChecklistBloc, ChecklistStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is ChecklistFetching ||
                  currentState is ChecklistFetched,
              listener: (context, state) {
                if (state is FetchingChecklistScheduleDates) {
                  ProgressBar.show(context);
                } else if (state is ChecklistDatesScheduled) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(
                      context, SystemUserScheduleDatesScreen.routeName);
                }
              },
              builder: (context, state) {
                if (state is ChecklistFetching) {
                  return const CircularProgressIndicator();
                } else if (state is ChecklistFetched) {
                  return SystemUserListLayout(
                      getChecklistModel: state.getChecklistModel);
                } else if (state is ChecklistError) {
                  return ShowError(onPressed: () {
                    context.read<ChecklistBloc>().add(FetchChecklist());
                  });
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    );
  }
}
