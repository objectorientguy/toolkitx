import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_bloc.dart';
import '../../../blocs/systemUser/checklist/checklist_events.dart';
import '../../../blocs/systemUser/checklist/checklist_states.dart';
import '../../../widgets/progress_bar.dart';
import '../../onboarding/widgets/show_error.dart';
import '../widgets/list_layout.dart';
import 'details_screen.dart';

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
                if (state is ChecklistDetailsFetching) {
                  ProgressBar.show(context);
                } else if (state is ChecklistDetailsFetched) {
                  ProgressBar.dismiss(context);
                  Navigator.pushNamed(
                      context, SystemUserDetailsScreen.routeName);
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
