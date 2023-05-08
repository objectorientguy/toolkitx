import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class ApiProvider {
  var headers = {'project-key': 'AC74F60A-5F01-4B87-836E-FD29C1D48487'};

  Future<dynamic> post(String requestUrl, Map body) async {
    log("post requestUrl-->$requestUrl");
    log("post body --> $body");
    dynamic responseJson;
    try {
      try {
        var url = Uri.parse(requestUrl);
        if (kDebugMode) {
          log("post request --> $url");
        }
        final response =
            await http.post(url, body: jsonEncode(body), headers: headers);
        responseJson = _response(response);
        if (kDebugMode) {
          log("post response Data --> $responseJson");
        }
        return responseJson;
      } catch (error) {
        if (kDebugMode) {
          log("post error --> $error");
        }
        rethrow;
      }
    } on SocketException {
      // throw FetchDataException("No Internet");
    }
  }

  Future<dynamic> get(String requestUrl, [String? token, Map? body]) async {
    log("get body-->$body");

    dynamic responseJson;
    try {
      try {
        var url = Uri.parse(requestUrl);
        if (kDebugMode) {
          log("get request-->$url");
        }
        final response = await http.get(url, headers: headers);
        responseJson = _response(response);
        if (kDebugMode) {
          log("get responseData-->$responseJson");
        }
        return responseJson;
      } catch (error) {
        if (kDebugMode) {
          log("get error-->$error");
        }
        rethrow;
      }
    } on SocketException {
      throw FetchDataException("No Internet");
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
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw BadResponseException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 204:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        var responseJson = json.decode(response.body.toString());
        if (responseJson["message"].toString() == "Unauthorized access") {
          // return showDialog(
          //     barrierDismissible: false,
          //     context: navigatorKey.currentContext!,
          //     builder: (context) => UnauthorizedUserPopup()
          // );
          break;
        } else {
          throw UnauthorisedException(response.body.toString());
        }
      case 500:
        throw BadResponseException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
