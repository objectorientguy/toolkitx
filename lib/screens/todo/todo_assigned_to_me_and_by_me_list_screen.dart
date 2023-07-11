import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assign_to_me_and_by_me_event.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assign_to_me_and_by_me_states.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assigned_to_me_and_by_me_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import 'widgets/todo_assigned_by_me_body.dart';
import 'widgets/todo_assigned_to_me_body.dart';

class TodoAssignedByMeAndToMeListScreen extends StatelessWidget {
  static const routeName = 'TodoAssignedByMeAndToMeListScreen';
  static int indexSelected = 0;

  const TodoAssignedByMeAndToMeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<TodoAssignedToMeAndByMeBloc>()
        .add(FetchTodoAssignedToMeAndByMeListEvent());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ToDo')),
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.only(
                left: leftRightMargin,
                right: leftRightMargin,
                top: xxTinierSpacing),
            child: Column(
              children: [
                const SizedBox(height: xxTinySpacing),
                BlocBuilder<TodoAssignedToMeAndByMeBloc,
                        TodoAssignedToMeAndByMeStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is TodoAssignedToMeAndByMeListFetched,
                    builder: (context, state) {
                      if (state is TodoAssignedToMeAndByMeListFetched) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ToggleSwitch(
                              animate: true,
                              minWidth: kToggleSwitchMinWidth,
                              initialLabelIndex: indexSelected,
                              cornerRadius: kToggleSwitchCornerRadius,
                              activeFgColor: AppColor.white,
                              inactiveBgColor: AppColor.grey,
                              inactiveFgColor: AppColor.white,
                              totalSwitches: 2,
                              labels: [
                                DatabaseUtil.getText('assignto'),
                                DatabaseUtil.getText('assignby')
                              ],
                              activeBgColors: const [
                                [AppColor.deepBlue],
                                [AppColor.errorRed]
                              ],
                              onToggle: (index) {
                                indexSelected = index!;
                                context.read<TodoAssignedToMeAndByMeBloc>().add(
                                    ToDoToggleIndex(
                                        selectedIndex: indexSelected,
                                        fetchToDoAssignToByListModel:
                                            state.fetchToDoAssignToByListModel,
                                        fetchToDoAssignToMeListModel: state
                                            .fetchToDoAssignToMeListModel));
                              },
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                const SizedBox(height: xxTinySpacing),
                BlocBuilder<TodoAssignedToMeAndByMeBloc,
                        TodoAssignedToMeAndByMeStates>(
                    buildWhen: (previousState, currentState) =>
                        currentState is FetchingTodoAssignedToMeAndByMeList ||
                        currentState is TodoAssignedToMeAndByMeListFetched,
                    builder: (context, state) {
                      if (state is FetchingTodoAssignedToMeAndByMeList) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3.5),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is TodoAssignedToMeAndByMeListFetched) {
                        if (indexSelected == 0) {
                          return TodoAssignedToMeBody(
                              assignToMeListDatum: state
                                  .fetchToDoAssignToMeListModel
                                  .assignToMeListDatum);
                        } else {
                          return TodoAssignedByMeBody(
                              assignedByMeListDatum: state
                                  .fetchToDoAssignToByListModel
                                  .assignedByMeListDatum);
                        }
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            )));
  }
}