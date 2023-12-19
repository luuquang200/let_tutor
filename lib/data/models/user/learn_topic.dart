class LearnTopicUser {
  final int id;
  final String key;
  final String name;

  LearnTopicUser({
    required this.id,
    required this.key,
    required this.name,
  });

  factory LearnTopicUser.fromJson(Map<String, dynamic> json) {
    return LearnTopicUser(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}
