import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class UserApiClient {
  // get user by id
  Future<User> getUserById(String id) async {
    log('calling get user by id api');
    try {
      final response = await DioClient.instance.get(
        '${Endpoints.userInformation}/$id',
      );
      return User.fromJson(response['user']);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get user by id api:');
      log('$e');
      rethrow;
    }
  }
}
