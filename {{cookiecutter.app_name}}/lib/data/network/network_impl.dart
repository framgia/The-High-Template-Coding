import 'dart:io';

import 'package:dio/dio.dart';

class Network {
  int _timeOut = 10000; //10s
  Dio _dio;

  Network() {
    BaseOptions options = BaseOptions(connectTimeout: _timeOut, receiveTimeout: _timeOut);
    Map<String, dynamic> headers = Map();
    /*
    Http request headers.
    headers["content-type"] = "application/json";
   */
    options.headers = headers;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> get({String url, Map<String, dynamic> params = const {}}) async {
    try {
      return await _dio.get(
        url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json),
      );
    } on DioError catch (e) {
      //handle error
      _handelError(e);
      print("DioError: ${e.toString()}");
    }
  }

  Future<Response> post({String url, Map<String, dynamic> body = const {}}) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        options: Options(responseType: ResponseType.json),
      );
      return response;
    } on DioError catch (e) {
      //handle error
      _handelError(e);
      print("DioError: ${e.toString()}");
    }
  }

  Response _handelError(dynamic error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.CANCEL:
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.DEFAULT:
            if (error.error is SocketException) {
              return ErrorResponse(
                data: error.error,
                statusMessage: error.message,
                statusCode: ErrorResponse.NETWORK_ERROR_CODE,
              );
            }
            return ErrorResponse(data: error.error, statusMessage: error.message);
          case DioErrorType.RESPONSE:
            return ErrorResponse(
              data: error.response.data,
              statusMessage: error.response.statusMessage,
              statusCode: error.response.statusCode,
            );
          default:
            return ErrorResponse(data: error.error, statusMessage: error.message);
        }
      }
    } catch (ex) {
      return ErrorResponse(data: ex.toString());
    }
    return ErrorResponse(data: error.toString());
  }
}

class ErrorResponse extends Response {
  static const int NETWORK_ERROR_CODE = 0;

  ErrorResponse({
    dynamic data,
    int statusCode,
    String statusMessage,
  }) : super(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
        );
}
