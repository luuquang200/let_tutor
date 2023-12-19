import 'package:let_tutor/data/models/tutors/category.dart';

class CategoryResponse {
  final String id;
  final String title;
  final List<MyCategory> categories;

  CategoryResponse(
      {required this.id, required this.title, required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    try {
      var categoryObjsJson = json['categories'] as List;
      List<MyCategory> categories = categoryObjsJson
          .map((categoryJson) => MyCategory.fromJson(categoryJson))
          .toList();

      return CategoryResponse(
        id: json['id'],
        title: json['title'],
        categories: categories,
      );
    } catch (e) {
      throw Exception('Error when parsing json to CategoryResponse: $e');
    }
  }
}
