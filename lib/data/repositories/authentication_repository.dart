import 'dart:developer';

import 'package:let_tutor/data/models/user/login_response.dart';
import 'package:let_tutor/data/network/apis/authentication_api_client.dart';

class AuthenticationRepository {
  late final AuthenticationApiClient _authenticationApiClient;
  final Map<String, String> registeredAccounts = {};

  Future<LoginResponse> signIn(String email, String password) async {
    // const fakeEmail = 't@gmail.com';
    // const fakePassword = 'p';
    // registeredAccounts[fakeEmail] = fakePassword;
    // log('email: $email, password: $password');
    // if (registeredAccounts[email] == password) {
    //   return Future.value();
    // } else {
    //   log('Invalid email or password');
    //   throw Exception('Invalid email or password');
    // }
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
