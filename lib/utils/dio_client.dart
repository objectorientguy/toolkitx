import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  Future<dynamic> get(String requestUrl, [Map? body]) async {
    dynamic jsonResponse;
    log('request url=======>$requestUrl');
    try {
      final response = await dio.get(requestUrl, options: Options());
      jsonResponse = (response.data);
      log('response =======>$jsonResponse');
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

  Future<dynamic> post(String requestUrl, Map? body) async {
    dynamic jsonResponse;
    log('request url=======>$requestUrl');
    try {
      final response =
          await dio.post(requestUrl, data: body, options: Options());
      jsonResponse = (response.data);
      log('response =======>$jsonResponse');
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
