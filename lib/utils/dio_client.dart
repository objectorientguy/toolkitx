import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();
  var headers = {'project-key': 'AC74F60A-5F01-4B87-836E-FD29C1D48487'};

  Future<dynamic> get(String requestUrl, [Map? body]) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.get(requestUrl, options: Options(headers: headers));
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
