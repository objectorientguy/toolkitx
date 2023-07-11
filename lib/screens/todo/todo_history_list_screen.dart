import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assign_to_me_and_by_me_event.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assign_to_me_and_by_me_states.dart';
import '../../blocs/todo/todoAssignToMeAndByMeList/todo_assigned_to_me_and_by_me_bloc.dart';
import '../../configs/app_color.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../data/models/status_tag_model.dart';
import '../../utils/database_utils.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/status_tag.dart';

class ToDoHistoryListScreen extends StatelessWidget {
  static const routeName = 'ToDoHistoryListScreen';

  const ToDoHistoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoAssignedToMeAndByMeBloc>().add(FetchToDoHistoryList());
    return Scaffold(
        appBar: const GenericAppBar(title: 'ToDo History'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: xxTinierSpacing),
          child: BlocBuilder<TodoAssignedToMeAndByMeBloc,
                  TodoAssignedToMeAndByMeStates>(
              buildWhen: (previousState, currentState) =>
                  currentState is FetchingTodoHistoryList ||
                  currentState is TodoHistoryListFetched,
              builder: (context, state) {
                if (state is FetchingTodoHistoryList) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoHistoryListFetched) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.fetchToDoHistoryListModel.data.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: tinierSpacing),
                                child: ListTile(
                                    onTap: () {},
                                    title: Text(
                                        state.fetchToDoHistoryListModel
                                            .data[index].todoname,
                                        style: Theme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.black)),
                                    subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                            top: tinierSpacing),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  state
                                                      .fetchToDoHistoryListModel
                                                      .data[index]
                                                      .description,
                                                  maxLines: 3),
                                              const SizedBox(
                                                  height: tinierSpacing),
                                              Text(
                                                  state
                                                      .fetchToDoHistoryListModel
                                                      .data[index]
                                                      .category,
                                                  maxLines: 3),
                                              const SizedBox(
                                                  height: tinierSpacing),
                                              Row(children: [
                                                Image.asset(
                                                    'assets/icons/calendar.png',
                                                    height: kImageHeight,
                                                    width: kImageWidth),
                                                const SizedBox(
                                                    width: tiniestSpacing),
                                                Text(state
                                                    .fetchToDoHistoryListModel
                                                    .data[index]
                                                    .duedate)
                                              ]),
                                              const SizedBox(
                                                  height: tinierSpacing),
                                              StatusTag(tags: [
                                                StatusTagModel(
                                                    title: (state
                                                                .fetchToDoHistoryListModel
                                                                .data[index]
                                                                .istododue ==
                                                            1)
                                                        ? DatabaseUtil.getText(
                                                            'Overdue')
                                                        : '',
                                                    bgColor: AppColor.errorRed),
                                              ])
                                            ])))));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: tinierSpacing);
                      });
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }
}
