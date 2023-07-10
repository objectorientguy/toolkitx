import 'dart:developer';

import 'package:toolkit/data/models/todo/fetch_assign_todo_by_me_list_model.dart';
import 'package:toolkit/data/models/todo/fetch_assign_todo_to_me_list_model.dart';
import 'package:toolkit/repositories/todo/todo_repository.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class ToDoRepositoryImpl extends ToDoRepository {
  @override
  Future<FetchToDoAssignToMeListModel> fetchToDoAssignToMeList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/get?pageno=1&hashcode=$hashCode&filter=$filter&userid=$userId");
    log("response====>$response");
    return FetchToDoAssignToMeListModel.fromJson(response);
  }

  @override
  Future<FetchToDoAssignToByListModel> fetchToDoAssignByMeList(
      int pageNo, String hashCode, String filter, String userId) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}todo/get?pageno=1&hashcode=$hashCode&filter=$filter&userid=$userId");
    log("response 2====>$response");
    return FetchToDoAssignToByListModel.fromJson(response);
  }
}
