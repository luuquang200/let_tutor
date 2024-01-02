import 'dart:developer';

import 'package:let_tutor/data/models/schedule/schedule_detail_info.dart';

class BookedSchedule {
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? googleMeetLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  String? cancelReasonId;
  int? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? isDeleted;
  bool? isTrial;
  int? convertedLesson;
  ScheduleDetailInfo? scheduleDetailInfo;

  BookedSchedule({
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.googleMeetLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.isDeleted,
    this.isTrial,
    this.convertedLesson,
    this.scheduleDetailInfo,
  });

  factory BookedSchedule.fromJson(Map<String, dynamic> json) {
    try {
      return BookedSchedule(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        scheduleDetailId: json['scheduleDetailId'] as String?,
        tutorMeetingLink: json['tutorMeetingLink'] as String?,
        studentMeetingLink: json['studentMeetingLink'] as String?,
        googleMeetLink: json['googleMeetLink'] as String?,
        studentRequest: json['studentRequest'] as String?,
        tutorReview: json['tutorReview'] as String?,
        scoreByTutor: json['scoreByTutor'] as int?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        recordUrl: json['recordUrl'] as String?,
        cancelReasonId: json['cancelReasonId'] as String?,
        lessonPlanId: json['lessonPlanId'] as int?,
        cancelNote: json['cancelNote'] as String?,
        calendarId: json['calendarId'] as String?,
        isDeleted: json['isDeleted'] as bool?,
        isTrial: json['isTrial'] as bool?,
        convertedLesson: json['convertedLesson'] as int?,
        scheduleDetailInfo: json['scheduleDetailInfo'] != null
            ? ScheduleDetailInfo.fromJson(
                json['scheduleDetailInfo'] as Map<String, dynamic>)
            : null,
      );
    } catch (e) {
      log('Error when parsing json to BookedSchedule: $e');
      throw Exception('$e');
    }
  }
}
