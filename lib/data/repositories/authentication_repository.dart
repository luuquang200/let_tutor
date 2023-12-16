import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/models/user/login_response.dart';
import 'package:let_tutor/data/network/apis/authentication_api_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class AuthenticationRepository {
  final AuthenticationApiClient _authenticationApiClient;
  final Map<String, String> registeredAccounts = {};

  AuthenticationRepository({AuthenticationApiClient? authenticationApiClient})
      : _authenticationApiClient =
            authenticationApiClient ?? AuthenticationApiClient();

  Future<LoginResponse> signIn(String email, String password) async {
    log('from repo : $email, password: $password');
    try {
      final response = await _authenticationApiClient.signIn(email, password);
      log('from repo response: $response');
      return response;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from repo: $e');
      rethrow;
      // Display e.toString() to the user
    }
  }

  Future<void> signUp(String email, String password) async {
    if (registeredAccounts.containsKey(email)) {
      throw Exception('Email already exists');
    } else {
      registeredAccounts[email] = password;
      return Future.value();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (registeredAccounts.containsKey(email)) {
      return Future.value();
    } else {
      throw Exception('Email does not exist');
    }
  }
}
