class LearnTopic {
  final int id;
  final String key;
  final String name;

  LearnTopic({
    required this.id,
    required this.key,
    required this.name,
  });

  factory LearnTopic.fromJson(Map<String, dynamic> json) {
    return LearnTopic(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}
