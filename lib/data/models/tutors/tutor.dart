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
        id: json['id'],
        name: json['name'],
        country: json['country'],
        avatar: json['avatar'],
        bio: json['bio'],
        isNative: json['isNative'],
        specialties: json['specialties'],
        rating: json['rating'],
        userId: json['userId'],
        schedulesTimes: json['schedulesTimes'],
        isFavorite: json['isFavorite'],
        price: json['price'],
        video: json['video'],
        education: json['education'],
        experience: json['experience'],
        interests: json['interests'],
        profession: json['profession'],
        languages: json['languages'],
        isFavoriteTutor: json['isFavoriteTutor'],
        totalFeedback: json['totalFeedback'],
        user: json['User'] != null ? User.fromJson(json['User']) : null,
      );
    } catch (e) {
      log('Error parsing tutor data: $e');
      throw Exception('Error parsing tutor data: $e');
    }
  }
}
