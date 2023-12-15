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
  final List<LearnTopic>? learnTopics;
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
    log('json from user: $json');
    // xuất tất cả các key và value của json
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
      roles: List<String>.from(json['roles']),
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      walletInfo: WalletInfo.fromJson(json['walletInfo']),
      courses: json['courses'],
      requireNote: json['requireNote'],
      level: json['level'],
      learnTopics: (json['learnTopics'] as List)
          .map((i) => LearnTopic.fromJson(i))
          .toList(),
      testPreparations: json['testPreparations'],
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      studySchedule: json['studySchedule'],
      canSendMessage: json['canSendMessage'],
    );
  }
}
