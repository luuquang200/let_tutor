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
    );
  }
}
