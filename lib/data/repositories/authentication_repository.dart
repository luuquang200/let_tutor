import 'dart:developer';

import 'package:let_tutor/data/models/user/login_response.dart';
import 'package:let_tutor/data/network/apis/authentication_api_client.dart';

class AuthenticationRepository {
  final AuthenticationApiClient _authenticationApiClient;
  final Map<String, String> registeredAccounts = {};

  AuthenticationRepository({AuthenticationApiClient? authenticationApiClient})
      : _authenticationApiClient =
            authenticationApiClient ?? AuthenticationApiClient();

  Future<LoginResponse> signIn(String email, String password) async {
    log('from repo : $email, password: $password');
    return await _authenticationApiClient.signIn(email, password);
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
