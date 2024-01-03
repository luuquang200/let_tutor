import 'dart:developer';

import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/data/models/schedule/schedule_response.dart';
import 'package:let_tutor/data/network/apis/schedule_api_client.dart';

class ScheduleRepository {
  final ScheduleApiClient _scheduleApiClient;

  ScheduleRepository({ScheduleApiClient? scheduleApiClient})
      : _scheduleApiClient = scheduleApiClient ?? ScheduleApiClient();

  // getBookedSchedule();
  Future<List<BookedSchedule>> getBookedSchedule(
      {int page = 1, int perPage = 20}) async {
    try {
      return await _scheduleApiClient.getNextBookedSchedule(page, perPage);
    } catch (e) {
      log('Error from get booked schedule repository: $e');
      rethrow;
    }
  }

  Future<List<BookedSchedule>> getScheduleList(
      {required int page, int perPage = 20}) async {
    try {
      return await _scheduleApiClient.getScheduleList(page, perPage);
    } catch (e) {
      log('Error from get schedule list repository: $e');
      rethrow;
    }
  }

  Future<void> cancelSchedule(String scheduleId) async {
    try {
      await _scheduleApiClient.cancelSchedule(scheduleId);
    } catch (e) {
      log('Error from cancel schedule repository: $e');
      rethrow;
    }
  }

  Future<void> updateRequest(String scheduleId, String request) async {
    try {
      await _scheduleApiClient.updateRequest(scheduleId, request);
    } catch (e) {
      log('Error from update request repository: $e');
      rethrow;
    }
  }

  Future<ScheduleResponse> getHistoryScheduleList(
      {required int page, int perPage = 20}) async {
    try {
      return await _scheduleApiClient.getHistoryScheduleList(page, perPage);
    } catch (e) {
      log('Error from get history schedule list repository: $e');
      rethrow;
    }
  }
}
