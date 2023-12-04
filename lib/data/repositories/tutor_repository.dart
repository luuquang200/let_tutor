import 'package:let_tutor/data/models/tutor.dart';

class TutorRepository {
  List<Tutor> tutors = [
    Tutor(
      id: '1',
      name: 'Mark Rice',
      country: 'Poland',
      language: 'English, Spanish',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 3.5,
      isFavorite: true,
      specialties: "business-english,conversational-english,toeic",
      bio:
          'I am passionate about football and coding, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '2',
      name: 'Adelia Rice Marry',
      country: 'United States',
      language: 'English, Spanish, French',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 5,
      specialties: "ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '3',
      name: 'Romina Todorova',
      country: 'Mexico',
      language: 'English, Mexican',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 4.5,
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '4',
      name: 'Bill Rice',
      country: 'United States',
      language: 'English, German, French, Spanish, Italian, Russian, Chinese',
      avatar: 'assets/tutor_avatar.jpg',
      rating: 3.5,
      isFavorite: true,
      specialties: "business-english,conversational-english,toeic",
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
    return tutors
        .where((tutor) =>
            tutor.specialties!.toLowerCase().contains(speciality.toLowerCase()))
        .toList();
  }

  Future<List<Tutor>> getTutorsByName(
      String name, int page, int tutorPerPage) async {
    await Future.delayed(const Duration(seconds: 1));
    return tutors
        .where(
            (tutor) => tutor.name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<List<Tutor>> filterTutors(
      Map<String, dynamic> filters, int page, int perPage) async {
    await Future.delayed(const Duration(seconds: 1));

    List<Tutor> filteredTutors = tutors;

    if (filters.containsKey('speciality')) {
      String speciality = filters['speciality'];
      filteredTutors = filteredTutors
          .where((tutor) => tutor.specialties!
              .toLowerCase()
              .contains(speciality.toLowerCase()))
          .toList();
    }

    if (filters.containsKey('name')) {
      String name = filters['name'];
      filteredTutors = filteredTutors
          .where(
              (tutor) => tutor.name!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }

    // Add more filters as needed

    // Implement pagination
    // int skip = (page - 1) * perPage;
    // filteredTutors = filteredTutors.skip(skip).take(perPage).toList();

    return filteredTutors;
  }

  // get tutor by id
  Future<Tutor> getTutorById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return tutors.firstWhere((tutor) => tutor.id == id);
  }
}
