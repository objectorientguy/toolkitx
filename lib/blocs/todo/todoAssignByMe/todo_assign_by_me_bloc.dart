import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import 'todo_assign_by_me_event.dart';
import 'todo_assign_by_me_states.dart';

class TodoAssignByMeListBloc
    extends Bloc<FetchTodoAssignByMeList, TodoAssignByMeListStates> {
  final ToDoRepository _toDoRepository = getIt<ToDoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TodoAssignByMeListStates get initialState =>
      TodoAssignByMeListTodoListInitial();

  TodoAssignByMeListBloc() : super(TodoAssignByMeListTodoListInitial()) {
    on<FetchTodoAssignByMeList>(_fetchToDoAssignByMeList);
  }

  FutureOr _fetchToDoAssignByMeList(FetchTodoAssignByMeList event,
      Emitter<TodoAssignByMeListStates> emit) async {
    emit(FetchingTodoAssignByMeList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchToDoAssignToByListModel fetchToDoAssignToByListModel =
          await _toDoRepository.fetchToDoAssignByMeList(
              1, hashCode!, 'assignedbyme', userId!);
      emit(TodoAssignByMeListFetched(
          fetchToDoAssignToByListModel: fetchToDoAssignToByListModel));
    } catch (e) {
      e.toString();
    }
  }
}
