import 'dart:developer';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/login_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';

class AuthenticationApiClient {
  // sign in
  Future<LoginResponse> signIn(String email, String password) async {
    log('call api: $email, password: $password');
    var response = await DioClient.instance
        .post(Endpoints.login, data: {'email': email, 'password': password});
    log('response: $response');
    final LoginResponse loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }
}
