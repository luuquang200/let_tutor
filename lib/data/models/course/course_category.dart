class CourseCategory {
  String? id;
  String? title;
  String? description;
  String? key;
  int? displayOrder;
  String? createdAt;
  String? updatedAt;

  CourseCategory({
    this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      key: json['key'] as String?,
      displayOrder: json['displayOrder'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}
