import 'package:toolkit/data/models/client/client_list_model.dart';
import 'package:toolkit/data/models/client/home_screen_model.dart';

abstract class ClientRepository {
  Future<ClientListModel> fetchClientList(
      String clientDataKey, String userType);

  Future<HomeScreenModel> fetchHomeScreen(Map processClientMap);
}
