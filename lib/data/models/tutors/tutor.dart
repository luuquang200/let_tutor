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
      this.isFavorite});

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
    );
  }

  factory Tutor.fromJson(Map<String, dynamic> json) {
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
      isFavorite: json['isFavoriteTutor'],
      price: json['price'],
    );
  }
}
