import '../../data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import '../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import '../../data/models/todo/fetch_todo_history_list_model.dart';

abstract class ToDoRepository {
  Future<FetchToDoAssignToMeListModel> fetchToDoAssignToMeList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchToDoAssignToByListModel> fetchToDoAssignByMeList(
      int pageNo, String hashCode, String filter, String userId);

  Future<FetchToDoHistoryListModel> fetchToDoHistoryList(
      int pageNo, String hashCode, String userId);
}
