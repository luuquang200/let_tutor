import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';
import 'package:let_tutor/data/network/interceptors/dio_interceptor.dart';

class DioClient {
  DioClient._() {
    _dio.interceptors.add(DioInterceptor(_dio));
  }

  static final instance = DioClient._();
  static const baseUrl = 'https://sandbox.api.lettutor.com';

  final Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json));

  ///Get Method
  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  ///Post Method
  Future<Map<String, dynamic>> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      log('from dio client: $data');
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
              followRedirects: false,
              validateStatus: (status) {
                return status != null ? status < 500 : false;
              },
            ) ??
            Options(
              followRedirects: false,
              validateStatus: (status) {
                return status != null ? status < 500 : false;
              },
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('call success !');
        return response.data;
      }
      throw response.data['message'];
    }
    // on DioException catch (e) {
    //   throw DioExceptionHandler.fromDioError(e);
    catch (e) {
      log('error: $e');
      rethrow;
    }
  }

  ///Put Method
  Future<Map<String, dynamic>> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  ///Delete Method
  Future<dynamic> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 204) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  determineErrorType(int? statusCode) {}
}
