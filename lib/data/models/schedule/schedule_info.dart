import 'package:let_tutor/data/models/schedule/tutor_info.dart';

class ScheduleInfo {
  final String? date;
  final int? startTimestamp;
  final int? endTimestamp;
  final String? id;
  final String? tutorId;
  final String? startTime;
  final String? endTime;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final TutorInfo? tutorInfo;

  ScheduleInfo({
    this.date,
    this.startTimestamp,
    this.endTimestamp,
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.tutorInfo,
  });

  factory ScheduleInfo.fromJson(Map<String, dynamic> json) {
    return ScheduleInfo(
      date: json['date'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      id: json['id'] as String?,
      tutorId: json['tutorId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      tutorInfo: json['tutorInfo'] != null
          ? TutorInfo.fromJson(json['tutorInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}
