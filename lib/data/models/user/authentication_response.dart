import 'package:let_tutor/data/models/tokens/tokens.dart';
import 'package:let_tutor/data/models/user/user.dart';

class AuthenticationResponse {
  final User user;
  final Tokens tokens;

  AuthenticationResponse({required this.user, required this.tokens});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticationResponse(
        user: User.fromJson(json['user']),
        tokens: Tokens.fromJson(json['tokens']),
      );
    } catch (e) {
      throw Exception('Error when parsing json to AuthenticationResponse');
    }
  }
}
