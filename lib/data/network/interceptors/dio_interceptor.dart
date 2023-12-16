import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';
import 'package:let_tutor/data/sharedpref/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor(this._dio) {
    initSharedPrefsHelper();
  }

  final Dio _dio;
  late SharedPreferenceHelper _sharedPrefsHelper;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Get the access token from shared preferences
    String? accessToken = await _sharedPrefsHelper.accessToken;

    // Add the access token to the headers
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Log the request
    log('Sending request to ${options.uri} with headers ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the response
    log('Received response: ${response.statusCode} ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the error
    log('Request error: ${err.message}');
    throw DioExceptionHandler.fromDioError(err);

    // super.onError(err, handler);
  }

  Future<void> initSharedPrefsHelper() async {
    _sharedPrefsHelper =
        SharedPreferenceHelper(await SharedPreferences.getInstance());
  }
}
