import 'dart:developer';
import 'package:let_tutor/data/models/tokens/access.dart';
import 'package:let_tutor/data/models/tokens/refresh.dart';

class Tokens {
  final Access access;
  final Refresh refresh;

  Tokens({required this.access, required this.refresh});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    try {
      return Tokens(
        access: Access.fromJson(json['access']),
        refresh: Refresh.fromJson(json['refresh']),
      );
    } catch (e) {
      log('error when parsing json to Tokens:');
      log('$e');
      throw Exception('Error when parsing json to Tokens');
    }
  }
}
