import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../blocs/todo/todoAssignToMe/todo_assign_to_me_bloc.dart';
import '../../blocs/todo/todoAssignToMe/todo_assign_to_me_event.dart';
import '../../utils/todo_tab_util.dart';
import '../../widgets/custom_tabbar_view.dart';
import 'widgets/todo_assigned_by_me_tab.dart';
import 'widgets/todo_assigned_to_me_tab.dart';

class TodoTabBarScreen extends StatelessWidget {
  static const routeName = 'TodoTabBarScreen';

  const TodoTabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoAssignToMeListBloc>().add(FetchTodoAssignToMeListEvent());
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
                CustomTabBarView(
                    lengthOfTabs: 2,
                    tabBarViewIcons: TodoTabUtil().tabBarViewIcons,
                    initialIndex: 0,
                    tabBarViewWidgets: const [
                      TodoAssignedToMeTab(),
                      TodoAssignedByMeTab()
                    ]),
              ],
            )));
  }
}
