import 'package:let_tutor/data/models/tutors/user_info.dart';

class TutorFeedback {
  final String? id;
  final String? bookingId;
  final String? firstId;
  final String? secondId;
  final int? rating;
  final String? content;
  final String? createdAt;
  final String? updatedAt;
  final UserInfo? firstInfo;

  TutorFeedback({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  factory TutorFeedback.fromJson(Map<String, dynamic> json) {
    return TutorFeedback(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: json['firstInfo'] != null
          ? UserInfo.fromJson(json['firstInfo'])
          : null,
    );
  }
}
