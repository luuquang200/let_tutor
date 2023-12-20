import 'dart:developer';

import 'package:let_tutor/data/models/tutors/feedback.dart';

class FeedbackResponse {
  final int? count;
  final List<TutorFeedback>? rows;

  FeedbackResponse({
    this.count,
    this.rows,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    try {
      return FeedbackResponse(
        count: json['count'],
        rows: (json['rows'] as List<dynamic>?)
            ?.map(
                (item) => TutorFeedback.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      log('Error parsing feedback response data: $e');
      rethrow;
    }
  }
}
