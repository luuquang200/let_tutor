import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/login_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class AuthenticationApiClient {
  // sign in
  Future<LoginResponse> signIn(String email, String password) async {
    log('call api: $email, password: $password');
    try {
      final response = await DioClient.instance.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      log('response: $response');
      return LoginResponse.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    }
  }
}
