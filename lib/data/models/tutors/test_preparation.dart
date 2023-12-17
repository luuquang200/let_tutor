class TestPreparation {
  final int? id;
  final String? key;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TestPreparation({
    this.id,
    this.key,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory TestPreparation.fromJson(Map<String, dynamic> json) {
    return TestPreparation(
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
