import 'dart:developer';

import 'package:let_tutor/data/models/tutors/schedule_detail.dart';

class TutorSchedule {
  final String id;
  final String tutorId;
  final String startTime;
  final String endTime;
  final int startTimestamp;
  final int endTimestamp;
  final String createdAt;
  final bool isBooked;
  final List<ScheduleDetail> scheduleDetails;

  TutorSchedule({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
  });

  factory TutorSchedule.fromJson(Map<String, dynamic> json) {
    var list = json['scheduleDetails'] as List;
    List<ScheduleDetail> scheduleDetailList =
        list.map((i) => ScheduleDetail.fromJson(i)).toList();
    return TutorSchedule(
      id: json['id'],
      tutorId: json['tutorId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startTimestamp: json['startTimestamp'],
      endTimestamp: json['endTimestamp'],
      createdAt: json['createdAt'],
      isBooked: json['isBooked'],
      scheduleDetails: scheduleDetailList,
    );
  }
}
