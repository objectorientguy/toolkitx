import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  Future<dynamic> get(String requestUrl, [Map? body]) async {
    dynamic jsonResponse;
    try {
      final response = await dio.get(requestUrl, options: Options());
      jsonResponse = (response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        e.response!.statusCode;
        e.response!.data;
      } else {
        e.message.toString();
      }
    }
    return jsonResponse;
  }
}
