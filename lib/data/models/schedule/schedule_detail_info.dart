import 'package:let_tutor/data/models/schedule/schedule_info.dart';

class ScheduleDetailInfo {
  final int? startPeriodTimestamp;
  final int? endPeriodTimestamp;
  final String? id;
  final String? scheduleId;
  final String? startPeriod;
  final String? endPeriod;
  final String? createdAt;
  final String? updatedAt;
  final ScheduleInfo? scheduleInfo;

  ScheduleDetailInfo({
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.scheduleInfo,
  });

  factory ScheduleDetailInfo.fromJson(Map<String, dynamic> json) {
    return ScheduleDetailInfo(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      id: json['id'] as String?,
      scheduleId: json['scheduleId'] as String?,
      startPeriod: json['startPeriod'] as String?,
      endPeriod: json['endPeriod'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      scheduleInfo: json['scheduleInfo'] != null
          ? ScheduleInfo.fromJson(json['scheduleInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}
