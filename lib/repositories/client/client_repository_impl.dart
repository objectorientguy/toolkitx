import 'package:toolkit/repositories/client/client_repository.dart';

import '../../data/models/client/client_list_model.dart';
import '../../data/models/client/home_screen_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/dio_client.dart';

class ClientRepositoryImpl extends ClientRepository {
  @override
  Future<ClientListModel> fetchClientList(
      String clientDataKey, String userType) async {
    final response = await DioClient().get(
        "${ApiConstants.baseUrl}/api/common/gethashkeys?data=$clientDataKey&type=$userType");
    return ClientListModel.fromJson(response);
  }

  @override
  Future<HomeScreenModel> fetchHomeScreen(Map processClientMap) async {
    final response = await DioClient().post(
        "${ApiConstants.baseUrl}/api/common/processclient", processClientMap);
    return HomeScreenModel.fromJson(response);
  }
}
