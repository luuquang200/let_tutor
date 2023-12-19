import 'dart:developer';

import 'package:let_tutor/data/models/user/learn_topic.dart';
import 'package:let_tutor/data/models/user/wallet_info.dart';

class User {
  final String? id;
  final String? email;
  final String? name;
  final String? avatar;
  final String? country;
  final String? phone;
  final List<String>? roles;
  final String? language;
  final String? birthday;
  final bool? isActivated;
  final WalletInfo? walletInfo;
  final List<dynamic>? courses;
  final String? requireNote;
  final String? level;
  final List<LearnTopicUser>? learnTopics;
  final List<dynamic>? testPreparations;
  final bool? isPhoneActivated;
  final int? timezone;
  final String? studySchedule;
  final bool? canSendMessage;

  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfo,
    this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      log('json from user: $json');
      json.forEach((key, value) {
        log('key: $key, value: $value');
      });

      return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        avatar: json['avatar'],
        country: json['country'],
        phone: json['phone'],
        roles: json['roles'] != null ? List<String>.from(json['roles']) : null,
        language: json['language'],
        birthday: json['birthday'],
        isActivated: json['isActivated'],
        walletInfo: json['walletInfo'] != null
            ? WalletInfo.fromJson(json['walletInfo'])
            : null,
        courses: json['courses'] != null
            ? List<dynamic>.from(json['courses'])
            : null,
        learnTopics: json['learnTopics'] != null
            ? (json['learnTopics'] as List)
                .map((i) => LearnTopicUser.fromJson(i))
                .toList()
            : null,
        testPreparations: json['testPreparations'] != null
            ? List<dynamic>.from(json['testPreparations'])
            : null,
        requireNote: json['requireNote'],
        level: json['level'],
        isPhoneActivated: json['isPhoneActivated'],
        timezone: json['timezone'],
        studySchedule: json['studySchedule'],
        canSendMessage: json['canSendMessage'],
      );
    } catch (e) {
      log('Error when parsing json to User:');
      log('$e');
      throw Exception('Error when parsing json to User');
    }
  }
}
