import 'dart:developer';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();
  final baseUrl = 'http://breeders.software/api/api/';
  var headers = {'project-key': 'AC74F60A-5F01-4B87-836E-FD29C1D48487'};

  Future<dynamic> get(String requestUrl, [String? token, Map? body]) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.get(requestUrl, options: Options(headers: headers));
      log('User Info: ${response.data}');
      jsonResponse = (response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
      } else {
        log('Error sending request!');
        log(e.message.toString());
      }
    }
    return jsonResponse;
  }
}
