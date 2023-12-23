import 'package:intl/intl.dart';

class ScheduleDetail {
  final int startPeriodTimestamp;
  final int endPeriodTimestamp;
  final String id;
  final String scheduleId;
  final String startPeriod;
  final String endPeriod;
  final String createdAt;
  final String updatedAt;
  final List bookingInfo;
  final bool isBooked;

  ScheduleDetail({
    required this.startPeriodTimestamp,
    required this.endPeriodTimestamp,
    required this.id,
    required this.scheduleId,
    required this.startPeriod,
    required this.endPeriod,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingInfo,
    required this.isBooked,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      startPeriodTimestamp: json['startPeriodTimestamp'],
      endPeriodTimestamp: json['endPeriodTimestamp'],
      id: json['id'],
      scheduleId: json['scheduleId'],
      startPeriod: json['startPeriod'],
      endPeriod: json['endPeriod'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      bookingInfo: json['bookingInfo'],
      isBooked: json['isBooked'],
    );
  }

  String get timeRange {
    final startTime =
        DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp * 1000)
            .toLocal();
    final endTime =
        DateTime.fromMillisecondsSinceEpoch(endPeriodTimestamp * 1000)
            .toLocal();

    final timeFormat = DateFormat.Hm(); // Use 24-hour format without AM/PM.
    return "${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}";
  }
}
