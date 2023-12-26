import 'package:let_tutor/data/models/schedule/schedule_detail_info.dart';

class BookedSchedule {
  final String? id;
  final String? userId;
  final String? scheduleDetailId;
  final String? tutorMeetingLink;
  final String? studentMeetingLink;
  final String? googleMeetLink;
  final String? studentRequest;
  final String? tutorReview;
  final int? scoreByTutor;
  final String? createdAt;
  final String? updatedAt;
  final String? recordUrl;
  final String? cancelReasonId;
  final String? lessonPlanId;
  final String? cancelNote;
  final String? calendarId;
  final bool? isDeleted;
  final bool? isTrial;
  final int? convertedLesson;
  final ScheduleDetailInfo? scheduleDetailInfo;

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
      lessonPlanId: json['lessonPlanId'] as String?,
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
  }
}
