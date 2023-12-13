class Access {
  final String token;
  final String expires;

  Access({required this.token, required this.expires});

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      token: json['token'],
      expires: json['expires'],
    );
  }
}
