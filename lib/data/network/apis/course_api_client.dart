import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/course/course.dart';
import 'package:let_tutor/data/models/course/course_category_response.dart';
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

  // getCourseCategories() {}
  Future<CourseCategoryResponse> getCourseCategories() async {
    log('calling get course categories api');
    try {
      var response =
          await DioClient.instance.get(Endpoints.getCourseCategories);
      CourseCategoryResponse contentCategoryResponse =
          CourseCategoryResponse.fromJson(response);
      return contentCategoryResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get course categories api:');
      log('$e');
      rethrow;
    }
  }

  Future<Course> getDetailCourse(String id) async {
    log('calling get detail course api');
    try {
      var response =
          await DioClient.instance.get('${Endpoints.getDetailCourse}/$id');
      Course course = Course.fromJson(response['data']);
      return course;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get detail course api:');
      log('$e');
      rethrow;
    }
  }

  // searchCourses(int page, int size, int perPage, Map<String, dynamic> map) {}
  Future<CourseResponse> searchCourses(
      int page, int size, Map<String, dynamic> map) async {
    log('calling search courses api');
    try {
      var response = await DioClient.instance.get(
        Endpoints.getCoursesList,
        queryParameters: {
          "page": page,
          "size": size,
          ...map,
        },
      );
      CourseResponse courseResponse = CourseResponse.fromJson(response['data']);
      return courseResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from search courses api:');
      log('$e');
      rethrow;
    }
  }

  Future<CourseResponse> searchEbooks(
      int page, int size, int perPage, Map<String, dynamic> map) async {
    log('calling search courses api');
    try {
      var response = await DioClient.instance.get(
        Endpoints.getEbooksList,
        queryParameters: {
          "page": page,
          "size": size,
          ...map,
        },
      );
      CourseResponse courseResponse = CourseResponse.fromJson(response['data']);
      return courseResponse;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from search courses api:');
      log('$e');
      rethrow;
    }
  }
}
