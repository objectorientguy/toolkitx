import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';

abstract class TodoAssignToMeListStates {}

class TodoAssignToMeListTodoListInitial extends TodoAssignToMeListStates {}

class FetchingTodoAssignToMeList extends TodoAssignToMeListStates {}

class TodoAssignToMeListFetched extends TodoAssignToMeListStates {
  final FetchToDoAssignToMeListModel fetchToDoAssignToMeListModel;

  TodoAssignToMeListFetched({required this.fetchToDoAssignToMeListModel});
}
