import 'dart:developer';

import 'package:let_tutor/data/models/user/user.dart';

class Tutor {
  String? id;
  String? name;
  String? country;
  String? avatar;
  String? language;
  String? specialties;
  String? interests;
  String? experience;
  String? bio;
  double? rating;
  bool? isFavorite;
  String? video;
  String? isNative;
  String? userId;
  int? schedulesTimes;
  int? price;
  String? education;
  String? profession;
  String? languages;
  int? totalFeedback;
  User? user;
  bool? isFavoriteTutor;

  Tutor(
      {this.id,
      this.name,
      this.country,
      this.avatar,
      this.language,
      this.specialties,
      this.interests,
      this.experience,
      this.rating,
      this.bio,
      this.video,
      this.isNative,
      this.userId,
      this.schedulesTimes,
      this.price,
      this.isFavorite,
      this.education,
      this.profession,
      this.languages,
      this.user,
      this.totalFeedback,
      this.isFavoriteTutor});

  Tutor copyWith({
    String? id,
    String? name,
    String? country,
    String? avatar,
    String? language,
    String? specialties,
    String? interests,
    String? experience,
    double? rating,
    String? bio,
    String? video,
    bool? isFavorite,
    String? isNative,
    String? userId,
    int? schedulesTimes,
    int? price,
    String? education,
    String? profession,
    String? languages,
    int? totalFeedback,
    User? user,
    bool? isFavoriteTutor,
  }) {
    return Tutor(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      avatar: avatar ?? this.avatar,
      language: language ?? this.language,
      specialties: specialties ?? this.specialties,
      interests: interests ?? this.interests,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      bio: bio ?? this.bio,
      video: video ?? this.video,
      isFavorite: isFavorite ?? this.isFavorite,
      isNative: isNative ?? this.isNative,
      userId: userId ?? this.userId,
      schedulesTimes: schedulesTimes ?? this.schedulesTimes,
      price: price ?? this.price,
      education: education ?? this.education,
      profession: profession ?? this.profession,
      languages: languages ?? this.languages,
      totalFeedback: totalFeedback ?? this.totalFeedback,
      user: user ?? this.user,
      isFavoriteTutor: isFavoriteTutor ?? this.isFavoriteTutor,
    );
  }

  factory Tutor.fromJson(Map<String, dynamic> json) {
    try {
      return Tutor(
        id: json['id'] as String?,
        name: json['name'] as String?,
        country: json['country'] as String?,
        avatar: json['avatar'] as String?,
        bio: json['bio'] as String?,
        isNative: json['isNative'] as String?,
        specialties: json['specialties'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        userId: json['userId'] as String?,
        schedulesTimes: json['schedulesTimes'] as int?,
        isFavorite: json['isFavorite'] as bool?,
        price: json['price'] as int?,
        video: json['video'] as String?,
        education: json['education'] as String?,
        experience: json['experience'] as String?,
        interests: json['interests'] as String?,
        profession: json['profession'] as String?,
        languages: json['languages'] as String?,
        isFavoriteTutor: json['isFavoriteTutor'] as bool?,
        totalFeedback: json['totalFeedback'] as int?,
        user: json['User'] != null ? User.fromJson(json['User']) : null,
      );
    } catch (e) {
      log('Error parsing tutor data: $e');
      throw Exception('Error parsing tutor data: $e');
    }
  }
}
