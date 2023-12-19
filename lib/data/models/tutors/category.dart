import 'dart:developer';

class MyCategory {
  final String? id;
  final String? description;
  final String? key;

  MyCategory({
    this.id,
    this.description,
    this.key,
  });

  factory MyCategory.fromJson(Map<String, dynamic> json) {
    try {
      return MyCategory(
        id: json['id'],
        description: json['description'],
        key: json['key'],
      );
    } catch (e) {
      log('Error when parsing json to MyCategory: $e');
      rethrow;
    }
  }
}
