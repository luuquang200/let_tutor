import 'package:let_tutor/data/models/user/learn_topic.dart';
import 'package:let_tutor/data/models/user/wallet_info.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String country;
  final String phone;
  final List<String> roles;
  final String? language;
  final String birthday;
  final bool isActivated;
  final WalletInfo walletInfo;
  final List<dynamic> courses;
  final String requireNote;
  final String level;
  final List<LearnTopic> learnTopics;
  final List<dynamic> testPreparations;
  final bool isPhoneActivated;
  final int timezone;
  final String studySchedule;
  final bool canSendMessage;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.country,
    required this.phone,
    required this.roles,
    this.language,
    required this.birthday,
    required this.isActivated,
    required this.walletInfo,
    required this.courses,
    required this.requireNote,
    required this.level,
    required this.learnTopics,
    required this.testPreparations,
    required this.isPhoneActivated,
    required this.timezone,
    required this.studySchedule,
    required this.canSendMessage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
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
