// Course_category_response
import 'package:let_tutor/data/models/course/course_category.dart';

class CourseCategoryResponse {
  final int count;
  final List<CourseCategory> rows;

  CourseCategoryResponse({required this.rows, required this.count});

  factory CourseCategoryResponse.fromJson(Map<String, dynamic> json) {
    try {
      var rowList = json['rows'] as List?;
      List<CourseCategory> rowsList = rowList != null
          ? rowList.map((v) => CourseCategory.fromJson(v)).toList()
          : [];

      return CourseCategoryResponse(
        rows: rowsList,
        count: json['count'] ?? 0,
      );
    } catch (e) {
      throw Exception('Error when parsing json to CourseCategoryResponse: $e');
    }
  }
}
