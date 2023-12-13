class Refresh {
  final String token;
  final String expires;

  Refresh({required this.token, required this.expires});

  factory Refresh.fromJson(Map<String, dynamic> json) {
    return Refresh(
      token: json['token'],
      expires: json['expires'],
    );
  }
}
