import 'package:let_tutor/data/models/course/course_category.dart';
import 'package:let_tutor/data/models/course/topic.dart';

class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  String? courseType;
  String? sectionType;
  bool? visible;
  int? displayOrder;
  String? createdAt;
  String? updatedAt;
  List<Topic>? topics;
  List<CourseCategory>? categories;

  Course({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      level: json['level'] as String?,
      reason: json['reason'] as String?,
      purpose: json['purpose'] as String?,
      otherDetails: json['otherDetails'] as String?,
      defaultPrice: json['defaultPrice'] as int?,
      coursePrice: json['coursePrice'] as int?,
      courseType: json['courseType'] as String?,
      sectionType: json['sectionType'] as String?,
      visible: json['visible'] as bool?,
      displayOrder: json['displayOrder'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CourseCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
