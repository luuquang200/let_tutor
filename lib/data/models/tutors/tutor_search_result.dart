import 'package:let_tutor/data/models/tutors/tutor.dart';

class TutorSearchResult {
  final int count;
  final List<Tutor> rows;

  TutorSearchResult({required this.count, required this.rows});

  factory TutorSearchResult.fromJson(Map<String, dynamic> json) {
    return TutorSearchResult(
      count: json['count'],
      rows: (json['rows'] as List).map((i) => Tutor.fromJson(i)).toList(),
    );
  }
}
