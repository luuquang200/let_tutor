import 'dart:developer';

import 'package:let_tutor/data/models/schedule/booked_schedule.dart';

class ScheduleResponse {
  final int count;
  final List<BookedSchedule> rows;

  ScheduleResponse({required this.rows, required this.count});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    try {
      var rowList = json['rows'] as List?;
      List<BookedSchedule> rowsList = rowList != null
          ? rowList.map((v) => BookedSchedule.fromJson(v)).toList()
          : [];

      return ScheduleResponse(
        rows: rowsList,
        count: json['count'] ?? 0,
      );
    } catch (e) {
      log('Error when parsing json to ScheduleResponse: $e');
      throw Exception('Error when parsing json to ScheduleResponse: $e');
    }
  }
}
