import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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

  // get total call
  Future<int> getTotalCall() async {
    log('calling get total call api');
    try {
      final response = await DioClient.instance.get(
        Endpoints.getTotalCall,
      );
      return response['total'];
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get total call api:');
      log('$e');
      rethrow;
    }
  }

  Future<User> getUserInformation() async {
    log('calling get user information api');
    try {
      final response = await DioClient.instance.get(
        Endpoints.userInformation,
      );
      return User.fromJson(response['user']);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get user information api:');
      log('$e');
      rethrow;
    }
  }

  Future<User> changeAvatar({required String avatarPath}) async {
    log('calling change avatar api');
    try {
      var file =
          await MultipartFile.fromFile(avatarPath, filename: 'avatar.png');
      var formData = FormData.fromMap({'avatar': file});

      final response = await DioClient.instance.post(
        Endpoints.changeAvatar,
        data: formData,
      );
      return User.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from change avatar api:');
      rethrow;
    }
  }

  //saveProfileSetting({required String name, required String country, required String birthday, required String level, required String studySchedule, required List<String> selectedLearnTopics, required List<String> selectedTestPreparations}) {}
  Future<User> saveProfileSetting(
      {required String name,
      required String country,
      required String birthday,
      required String level,
      required String studySchedule,
      required List<String> selectedLearnTopics,
      required List<String> selectedTestPreparations}) async {
    log('calling save profile setting api');
    try {
      final response = await DioClient.instance.put(
        Endpoints.userInformation,
        data: {
          'name': name,
          'country': country,
          'birthday': birthday,
          'level': level,
          'studySchedule': studySchedule,
          'learnTopics': selectedLearnTopics,
          'testPreparations': selectedTestPreparations
        },
      );
      return User.fromJson(response['user']);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from save profile setting api:');
      rethrow;
    }
  }
}
