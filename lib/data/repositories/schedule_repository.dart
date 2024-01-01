import 'dart:developer';

import 'package:let_tutor/data/models/schedule/booking.dart';
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
}
