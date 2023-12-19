import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/authentication_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class AuthenticationApiClient {
  // sign in
  Future<AuthenticationResponse> signIn(String email, String password) async {
    try {
      final response = await DioClient.instance.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      AuthenticationResponse loginResponse =
          AuthenticationResponse.fromJson(response);
      return loginResponse;
      // return LoginResponse.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow;
    }
  }

  // sign up
  Future<AuthenticationResponse> signUp(String email, String password) async {
    try {
      final response = await DioClient.instance.post(
        Endpoints.register,
        data: {'email': email, 'password': password, "source": null},
      );
      AuthenticationResponse loginResponse =
          AuthenticationResponse.fromJson(response);
      return loginResponse;
      // return LoginResponse.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow;
    }
  }

  // reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await DioClient.instance.post(
        Endpoints.resetPassword,
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error when handling response from api: $e');
      rethrow;
    }
  }
}
