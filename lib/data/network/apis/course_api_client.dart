import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/course/course_reponse.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class CourseApiClient {
  // get course list
  Future<CourseResponse> getCoursesList(int page, int size) async {
    log('calling get courses list api');
    try {
      var response = await DioClient.instance.get(
        Endpoints.getCoursesList,
        queryParameters: {"page": page, "size": size},
      );
      CourseResponse courseResponse = CourseResponse.fromJson(response['data']);
      return courseResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get courses list api:');
      log('$e');
      rethrow;
    }
  }
}
