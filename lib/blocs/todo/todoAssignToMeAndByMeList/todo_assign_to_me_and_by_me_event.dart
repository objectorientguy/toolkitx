import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';

abstract class ToDoAssignedToMeAndByMeEvent {}

class FetchTodoAssignedToMeAndByMeListEvent
    extends ToDoAssignedToMeAndByMeEvent {
  FetchTodoAssignedToMeAndByMeListEvent();
}

class ToDoToggleIndex extends ToDoAssignedToMeAndByMeEvent {
  final int selectedIndex;
  final FetchToDoAssignToByListModel? fetchToDoAssignToByListModel;
  final FetchToDoAssignToMeListModel? fetchToDoAssignToMeListModel;

  ToDoToggleIndex(
      {this.fetchToDoAssignToMeListModel,
      this.fetchToDoAssignToByListModel,
      required this.selectedIndex});
}

class FetchToDoDetails extends ToDoAssignedToMeAndByMeEvent {}
