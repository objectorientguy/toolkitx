import '../../data/models/client/client_list_model.dart';
import '../../data/models/client/home_screen_model.dart';

abstract class ClientStates {}

class ClientInitial extends ClientStates {}

class ClientListFetching extends ClientStates {}

class ClientListFetched extends ClientStates {
  final ClientListModel clientListModel;

  ClientListFetched({required this.clientListModel});
}

class FetchClientListError extends ClientStates {}

class HomeScreenFetching extends ClientStates {}

class HomeScreenFetched extends ClientStates {
  final HomeScreenModel processClientModel;
  final String image;
  final List availableModules;
  HomeScreenFetched(
      {required this.processClientModel,
      required this.image,
      required this.availableModules});
}

class FetchHomeScreenError extends ClientStates {}
