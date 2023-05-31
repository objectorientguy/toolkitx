abstract class ClientEvents {}

class FetchClientList extends ClientEvents {}

class FetchHomeScreenData extends ClientEvents {
  final String hashKey;
  final String apiKey;
  final String image;

  FetchHomeScreenData(
      {required this.hashKey, required this.apiKey, required this.image});
}
