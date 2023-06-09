import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  Future<dynamic> get(String requestUrl, [Map? body]) async {
    dynamic jsonResponse;
    log('requestUrl get=======>$requestUrl');
    try {
      final response = await dio.get(requestUrl, options: Options());
      jsonResponse = (response.data);
      log('jsonResponse get=======>$jsonResponse');
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
    log('requestUrl post=======>$requestUrl');
    try {
      final response =
          await dio.post(requestUrl, data: body, options: Options());
      jsonResponse = (response.data);
      log('jsonResponse post=======>$jsonResponse');
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

  Future<dynamic> multiPart(
      String requestUrl, Map body, File documentFile) async {
    log("multiPart requestUrl-->$requestUrl");
    log("multiPart body-->$body");
    dynamic responseJson;
    try {
      try {
        var url = Uri.parse(requestUrl);
        http.MultipartRequest request = http.MultipartRequest('POST', url)
          ..fields['hashcode'] = jsonEncode(body)
          ..files
              .add(await http.MultipartFile.fromPath('0', documentFile.path));
        responseJson = await request.send();
        responseJson = await multiPartResponse(responseJson);
        log("multiPart responseData-->$responseJson");
        return await responseJson;
      } catch (error) {
        log("multiPart error-->$error");
      }
    } catch (e) {
      log("errorr=======>${e.toString()}");
    }
  }

  dynamic multiPartResponse(var response) async {
    switch (response.statusCode) {
      case 200:
        final responseString = await response.stream.bytesToString();
        var responseJson = json.decode(responseString);
        return responseJson;
      case 204:
        final responseString = await response.stream.bytesToString();
        var responseJson = json.decode(responseString);
        return responseJson;
    }
  }

// Future<dynamic> multiPart(
//   String requestUrl,
//   Map body,
// ) async {
//   dynamic jsonResponse;
//   try {
//     log("multi part url======>$requestUrl");
//     final response = await dio.post(requestUrl, data: body);
//     jsonResponse(response.data);
//     log("multi part response======>$jsonResponse");
//   } on DioError catch (e) {
//     if (e.response != null) {
//       e.response!.statusCode;
//       e.response!.data;
//     } else {
//       e.message.toString();
//     }
//   }
//   return jsonResponse;
// }
}
