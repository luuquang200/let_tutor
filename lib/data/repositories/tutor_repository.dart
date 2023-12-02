import 'package:let_tutor/data/models/tutor.dart';

class TutorRepository {
  List<Tutor> tutors = [
    Tutor(
      name: 'Adelia Rice Brown',
      country: 'United States',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 3.5,
      isFavorite: true,
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      name: 'Adelia Rice Marry',
      country: 'United States',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 5,
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      name: 'Adelia Rice',
      country: 'United States',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 4.5,
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      name: 'Adelia Rice',
      country: 'United States',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 3.5,
      isFavorite: true,
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
  ];

  Future<List<Tutor>> getTutors() async {
    await Future.delayed(const Duration(seconds: 1));
    return tutors;
  }

  Future<List<Tutor>> getTutorsBySpeciality(
      String speciality, int page, int tutorPerPage) async {
    await Future.delayed(const Duration(seconds: 1));
    return tutors;
  }
}
