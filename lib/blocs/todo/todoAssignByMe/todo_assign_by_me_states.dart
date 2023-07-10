import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';

abstract class TodoAssignByMeListStates {}

class TodoAssignByMeListTodoListInitial extends TodoAssignByMeListStates {}

class FetchingTodoAssignByMeList extends TodoAssignByMeListStates {}

class TodoAssignByMeListFetched extends TodoAssignByMeListStates {
  final FetchToDoAssignToByListModel fetchToDoAssignToByListModel;

  TodoAssignByMeListFetched({required this.fetchToDoAssignToByListModel});
}
