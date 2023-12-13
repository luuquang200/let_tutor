import 'package:let_tutor/data/models/tokens/tokens.dart';
import 'package:let_tutor/data/models/user/user.dart';

class LoginResponse {
  final User user;
  final Tokens tokens;

  LoginResponse({required this.user, required this.tokens});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}
