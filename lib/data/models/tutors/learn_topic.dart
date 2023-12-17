class LearnTopic {
  final int? id;
  final String? key;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LearnTopic({
    this.id,
    this.key,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory LearnTopic.fromJson(Map<String, dynamic> json) {
    return LearnTopic(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
