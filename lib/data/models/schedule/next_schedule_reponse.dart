import 'package:let_tutor/data/models/schedule/booking.dart';

class NextScheduleResponse {
  final String message;
  final List<BookedSchedule> data;

  NextScheduleResponse({required this.data, required this.message});

  factory NextScheduleResponse.fromJson(Map<String, dynamic> json) {
    try {
      var dataList = json['data'] as List?;
      List<BookedSchedule> dataListItems = dataList != null
          ? dataList.map((v) => BookedSchedule.fromJson(v)).toList()
          : [];

      return NextScheduleResponse(
        data: dataListItems,
        message: json['message'] ?? '',
      );
    } catch (e) {
      throw Exception('Error when parsing json to NextScheduleResponse: $e');
    }
  }
}
