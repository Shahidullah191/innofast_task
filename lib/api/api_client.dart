import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get.dart';
import 'package:innofast_task/api/error_response.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    updateHeader();
  }

  void updateHeader() {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.get(
        Uri.parse(appBaseUrl+uri,),
        headers: headers ?? _mainHeaders,

      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } on SocketException {
      return Response(statusCode: 1, statusText: 'No internet connection');
    } on TimeoutException {
      return Response(statusCode: 1, statusText: 'Connection timeout');
    } on FormatException {
      return Response(statusCode: 1, statusText: 'Bad response format');
    } catch (e, stack) {
      if (kDebugMode) {
        log('Unhandled exception during API call: $e\n$stack');
      }
      return Response(statusCode: 1, statusText: 'Unexpected error occurred');
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(_) {}
    Response response0 = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(response0.statusCode != 200 && response0.body != null && response0.body is !String) {
      if(response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.errors![0].message);
      }else if(response0.body.toString().startsWith('{message')) {
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
      }
    }else if(response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(kDebugMode) {
      log('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    return response0;
  }
}
