import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/tutors/category.dart';
import 'package:let_tutor/data/models/tutors/category_reponse.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';
import 'package:let_tutor/data/models/tutors/feedback_response.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/data/models/tutors/tutor_schedule.dart';
import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class TutorApiClient {
  Future<TutorSearchResult> searchTutor(
      Map<String, dynamic> filters, int page, int perPage, String? name) async {
    log('calling search tutor api');
    try {
      var data = {'filters': filters, 'page': page, 'perPage': perPage};
      if (name != null) {
        data['search'] = name;
      }
      final response = await DioClient.instance.post(
        Endpoints.searchTutor,
        data: data,
      );
      return TutorSearchResult.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from search tutor api: $e');
      rethrow;
    }
  }

  // get learn topic
  Future<List<LearnTopic>> getLearnTopic() async {
    log('calling get learn topic api');
    try {
      final response = await DioClient.instance.get(Endpoints.getLearnTopic);
      return (response as List)
          .map((e) => LearnTopic.fromJson(e))
          .toList(growable: false);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from get learn topic api:');
      log('$e');
      rethrow;
    }
  }

  // get test preparation
  Future<List<TestPreparation>> getTestPreparation() async {
    log('calling get test preparation api');
    try {
      final response =
          await DioClient.instance.get(Endpoints.getTestPreparation);
      return (response as List)
          .map((e) => TestPreparation.fromJson(e))
          .toList(growable: false);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from get test preparation api: $e');
      rethrow;
    }
  }

  // get tutor by id
  Future<Tutor> getTutorById(String tutorId) async {
    log('calling get tutor by id api');
    try {
      final response =
          await DioClient.instance.get('${Endpoints.getTutorDetails}/$tutorId');
      return Tutor.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('error handling from get tutor by id api: $e');
      rethrow;
    }
  }

  // get categories
  Future<List<MyCategory>> getListLanguages() async {
    log('calling get categories api');
    try {
      var response = await DioClient.instance.get(Endpoints.getCategories);
      CategoryResponse firstElement = CategoryResponse.fromJson(response[0]);

      return firstElement.categories;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get categories api:');
      log('$e');
      rethrow;
    }
  }

  // favourite tutor
  Future<bool> favouriteTutor(String tutorId) async {
    String manageSuccess = 'Manage success';
    log('calling favourite tutor api');
    try {
      var response = await DioClient.instance.post(
        Endpoints.manageFavoriteTutor,
        data: {'tutorId': tutorId},
      );
      return response['message'] == manageSuccess;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from favourite tutor api:');
      log('$e');
      rethrow;
    }
  }

  // get feedbacks
  Future<List<TutorFeedback>> getFeedbacks(String tutorId) async {
    log('calling get feedbacks api');
    try {
      var response = await DioClient.instance.get(
        '${Endpoints.getFeedbacks}/$tutorId',
      );
      FeedbackResponse feedbackResponse =
          FeedbackResponse.fromJson(response["data"]);
      return feedbackResponse.rows ?? [];
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get feedbacks api:');
      log('$e');
      rethrow;
    }
  }

  // report tutor
  Future<bool> reportTutor(String tutorId, String content) async {
    log('calling report tutor api');
    try {
      await DioClient.instance.post(
        Endpoints.reportTutor,
        data: {'tutorId': tutorId, 'content': content},
      );
      return true;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from report tutor api:');
      log('$e');
      rethrow;
    }
  }

  Future<List<TutorSchedule>> getScheduleOfTutor(String tutorId) async {
    log('calling get schedule of tutor api');
    try {
      Map<String, dynamic> response = await DioClient.instance.get(
        Endpoints.getSchedule,
        queryParameters: {'tutorId': tutorId, 'page': 0},
      );

      List<TutorSchedule> schedules;
      if (response["scheduleOfTutor"] == null) {
        schedules = <TutorSchedule>[];
      } else {
        schedules = (response["scheduleOfTutor"] as List)
            .map((e) => TutorSchedule.fromJson(e))
            .toList(growable: false);
      }

      return schedules;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get schedule of tutor api:');
      log('$e');
      rethrow;
    }
  }

  // book tutor
  Future<void> bookTutor(String scheduleId, String note) async {
    log('calling book tutor api');
    try {
      await DioClient.instance.post(
        Endpoints.bookTutor,
        data: {
          'scheduleDetailIds': [scheduleId],
          'note': note,
        },
      );
    } catch (e) {
      log('Error handling from book tutor api:');
      log('$e');
      rethrow;
    }
  }
}
