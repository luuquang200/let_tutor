class Topic {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  int? numberOfPages;
  String? description;
  String? videoUrl;
  String? type;
  String? createdAt;
  String? updatedAt;

  Topic({
    this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.nameFile,
    this.numberOfPages,
    this.description,
    this.videoUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] as String?,
      courseId: json['courseId'] as String?,
      orderCourse: json['orderCourse'] as int?,
      name: json['name'] as String?,
      nameFile: json['nameFile'] as String?,
      numberOfPages: json['numberOfPages'] as int?,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}
