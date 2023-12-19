import 'dart:developer';

import 'package:let_tutor/data/models/tutors/tutor.dart';

class TutorSearchResult {
  final int count;
  final List<Tutor> rows;

  TutorSearchResult({required this.count, required this.rows});

  factory TutorSearchResult.fromJson(Map<String, dynamic> json) {
    try {
      return TutorSearchResult(
        count: json['count'],
        rows: (json['rows'] as List).map((i) => Tutor.fromJson(i)).toList(),
      );
    } catch (e) {
      log('Error parsing tutor search result: $e');
      throw Exception('Error parsing tutor search result: $e');
    }
  }
}
