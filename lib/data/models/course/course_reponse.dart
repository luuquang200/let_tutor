import 'dart:developer';

import 'package:let_tutor/data/models/course/course.dart';

class CourseResponse {
  final int count;
  final List<Course> rows;

  CourseResponse({required this.rows, required this.count});

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    try {
      var rowList = json['rows'] as List?;
      List<Course> rowsList = rowList != null
          ? rowList.map((v) => Course.fromJson(v)).toList()
          : [];

      return CourseResponse(
        rows: rowsList,
        count: json['count'] ?? 0,
      );
    } catch (e) {
      log('Error when parsing json to ScheduleResponse: $e');
      throw Exception('Error when parsing json to ScheduleResponse: $e');
    }
  }
}
