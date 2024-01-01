import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:let_tutor/constants/endpoints.dart';
import 'package:let_tutor/data/models/schedule/booking.dart';
import 'package:let_tutor/data/models/schedule/next_schedule_reponse.dart';
import 'package:let_tutor/data/models/schedule/schedule_response.dart';
import 'package:let_tutor/data/network/dio_client.dart';
import 'package:let_tutor/data/network/exceptions/dio_exception_handler.dart';

class ScheduleApiClient {
  // get booked schedule
  Future<List<BookedSchedule>> getNextBookedSchedule(
      int page, int perPage) async {
    log('calling get booked schedule api');
    try {
      var response = await DioClient.instance.get(
        Endpoints.getNextBookedSchedule,
        queryParameters: {
          "page": page,
          "perPage": perPage,
          "orderBy": "meeting",
          "sortedBy": "desc"
        },
      );
      NextScheduleResponse scheduleResponse =
          NextScheduleResponse.fromJson(response);
      return scheduleResponse.data;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get booked schedule api:');
      log('$e');
      rethrow;
    }
  }

  // getScheduleList(int page, int perPage) {}
  Future<List<BookedSchedule>> getScheduleList(int page, int perPage) async {
    log('calling get schedule list api');
    try {
      var response = await DioClient.instance.get(
        Endpoints.getScheduleList,
        queryParameters: {
          "page": page,
          "perPage": perPage,
          "inFuture": 1,
          "orderBy": "meeting",
          "sortedBy": "asc"
        },
      );
      ScheduleResponse scheduleResponse =
          ScheduleResponse.fromJson(response['data']);
      return scheduleResponse.rows;
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e);
    } catch (e) {
      log('Error handling from get schedule list api:');
      log('$e');
      rethrow;
    }
  }
}
