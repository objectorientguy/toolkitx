import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/todo/todoAssignToMe/todo_assign_to_me_event.dart';
import 'package:toolkit/blocs/todo/todoAssignToMe/todo_assign_to_me_states.dart';
import 'package:toolkit/data/cache/cache_keys.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';
import '../../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../data/models/todo/fetch_assign_todo_to_me_list_model.dart';

class TodoAssignToMeListBloc
    extends Bloc<FetchTodoAssignToMeListEvent, TodoAssignToMeListStates> {
  final ToDoRepository _toDoRepository = getIt<ToDoRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  TodoAssignToMeListStates get initialState =>
      TodoAssignToMeListTodoListInitial();

  TodoAssignToMeListBloc() : super(TodoAssignToMeListTodoListInitial()) {
    on<FetchTodoAssignToMeListEvent>(_fetchToDoAssignToMeList);
  }

  FutureOr _fetchToDoAssignToMeList(FetchTodoAssignToMeListEvent event,
      Emitter<TodoAssignToMeListStates> emit) async {
    emit(FetchingTodoAssignToMeList());
    try {
      String? userId = await _customerCache.getUserId(CacheKeys.userId);
      String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
      FetchToDoAssignToMeListModel fetchToDoAssignToMeListModel =
          await _toDoRepository.fetchToDoAssignToMeList(
              1, hashCode!, 'assignedtome', userId!);
      emit(TodoAssignToMeListFetched(
          fetchToDoAssignToMeListModel: fetchToDoAssignToMeListModel));
    } catch (e) {
      e.toString();
    }
  }

// FutureOr _fetchToDoAssignByMeList(
//     FetchTodoAssignByMeList event, Emitter<TodoAssignToMeListStates> emit) async {
//   emit(FetchingTodoAssignToMeList());
//   try {
//     String? userId = await _customerCache.getUserId(CacheKeys.userId);
//     String? hashCode = await _customerCache.getHashCode(CacheKeys.hashcode);
//     FetchToDoAssignToByListModel fetchToDoAssignToByListModel =
//         await _toDoRepository.fetchToDoAssignByMeList(
//             1, hashCode!, 'assignedbyme', userId!);
//     emit(TodoAssignByMeListFetched(
//         fetchToDoAssignToByListModel: fetchToDoAssignToByListModel));
//   } catch (e) {
//     e.toString();
//   }
// }
}
