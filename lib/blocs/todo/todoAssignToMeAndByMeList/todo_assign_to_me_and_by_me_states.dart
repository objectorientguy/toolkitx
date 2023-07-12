import '../../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../../data/models/todo/fetch_todo_details_model.dart';

abstract class TodoAssignedToMeAndByMeStates {}

class TodoAssignedToMeAndByMeInitial extends TodoAssignedToMeAndByMeStates {}

class FetchingTodoAssignedToMeAndByMeList
    extends TodoAssignedToMeAndByMeStates {}

class TodoAssignedToMeAndByMeListFetched extends TodoAssignedToMeAndByMeStates {
  final FetchToDoAssignToMeListModel fetchToDoAssignToMeListModel;
  final FetchToDoAssignToByListModel fetchToDoAssignToByListModel;
  final int? selectedIndex;

  TodoAssignedToMeAndByMeListFetched(
      {required this.fetchToDoAssignToByListModel,
      this.selectedIndex,
      required this.fetchToDoAssignToMeListModel});
}

class FetchingTodoDetails extends TodoAssignedToMeAndByMeStates {}

class TodoDetailsFetched extends TodoAssignedToMeAndByMeStates {
  final FetchToDoDetailsModel fetchToDoDetailsModel;

  TodoDetailsFetched({required this.fetchToDoDetailsModel});
}
