class UserInfo {
  final String? name;
  final String? avatar;

  UserInfo({
    this.name,
    this.avatar,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
