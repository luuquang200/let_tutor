import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:let_tutor/data/models/tutors/category.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/data/models/tutors/tutor_schedule.dart';
import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/network/apis/tutor_api_client.dart';

class TutorRepository {
  final tutorApiClient = TutorApiClient();
  List<Tutor> tutors = [
    Tutor(
      id: '1',
      name: 'Mark Rice',
      country: 'TN',
      language: 'English, Spanish',
      avatar:
          'https://sandbox.api.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1684484879187.jpg',
      rating: 3.5,
      video:
          'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4',
      isFavorite: true,
      experience: 'I have more than 10 years of teaching english experience',
      interests:
          'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
      specialties: "business-english,conversational-english,toeic",
      bio:
          'I am passionate about football and coding, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '2',
      name: 'Adelia Rice Marry',
      country: 'TN',
      language: 'English, Spanish, French',
      avatar:
          'https://sandbox.api.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1684484879187.jpg',
      rating: 5,
      isFavorite: false,
      video:
          'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4',
      experience: 'I have more than 10 years of teaching english experience',
      interests:
          'I like to travel and meet new people. Go to the bar and drink beer with my friends.',
      specialties: "ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '3',
      name: 'Romina Todorova',
      country: 'KI',
      language: 'English, Mexican',
      isFavorite: false,
      avatar:
          'https://sandbox.api.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1684484879187.jpg',
      rating: 4.5,
      video:
          'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4',
      experience: 'I have more than 10 years of teaching english experience',
      interests:
          'I like football and coding. Sometimes I go to massage and spa to relax myself.',
      specialties:
          "business-english,conversational-english,english-for-kids,ielts,starters,movers,flyers,ket,pet,toefl,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
    Tutor(
      id: '4',
      name: 'Bill Rice',
      country: 'TW',
      language: 'English, German, French, Spanish, Italian, Russian, Chinese',
      avatar:
          'https://api.app.lettutor.com/avatar/e9e3eeaa-a588-47c4-b4d1-ecfa190f63faavatar1632109929661.jpg',
      rating: 3.5,
      video:
          'https://api.app.lettutor.com/video/e9e3eeaa-a588-47c4-b4d1-ecfa190f63favideo1632109929663.mp4',
      experience: 'I have more than 8 years of teaching english experience',
      interests:
          'I like to travel and meet new people. Go to the bar and drink beer with my friends.',
      isFavorite: true,
      specialties: "business-english,conversational-english,toeic",
      bio:
          'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
    ),
  ];

  Future<List<Tutor>> getTutors() async {
    TutorSearchResult result =
        await tutorApiClient.searchTutor({}, 1, 12, null);
    List<Tutor> tutors = result.rows;
    return tutors;
  }

  // get learn topic
  Future<List<LearnTopic>> getLearnTopic() async {
    List<LearnTopic> learnTopics = await tutorApiClient.getLearnTopic();
    return learnTopics;
  }

  // get test preparation
  Future<List<TestPreparation>> getTestPreparation() async {
    List<TestPreparation> testPreparations =
        await tutorApiClient.getTestPreparation();
    return testPreparations;
  }

  // search tutor
  Future<List<Tutor>> searchTutor(
      Map<String, dynamic> filters, int page, int perPage, String? name) async {
    TutorSearchResult result =
        await tutorApiClient.searchTutor(filters, page, perPage, name);
    List<Tutor> tutors = result.rows;
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
    Tutor tutor = await tutorApiClient.getTutorById(id);
    return tutor;
  }

  Future<List<TutorSchedule>> getScheduleOfTutor(String tutorId) async {
    await Future.delayed(const Duration(seconds: 1));
    log('message');
    // Load and decode the JSON file
    String jsonString =
        await rootBundle.loadString('assets/jsons/test_schedule.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    log('Load schedule of tutor $tutorId');
    // Create a list of TutorSchedule objects from the JSON data
    var list = jsonData['scheduleOfTutor'] as List;
    List<TutorSchedule> tutorSchedules =
        list.map((data) => TutorSchedule.fromJson(data)).toList();
    // log('Schedule: $tutorSchedules');
    // for (var tutorSchedule in tutorSchedules) {
    //   log('Schedule: ${tutorSchedule.scheduleDetails}');
    // }

    return tutorSchedules;
  }

  Future<bool> favouriteTutor(String tutorId) async {
    return await tutorApiClient.favouriteTutor(tutorId);
  }

  // report tutor
  Future<bool> reportTutor(String tutorId, String content) async {
    return await tutorApiClient.reportTutor(tutorId, content);
  }

  // get categories
  Future<List<MyCategory>> getListLanguages() async {
    List<MyCategory> categories = await tutorApiClient.getListLanguages();
    return categories;
  }

  // get feedbacks
  Future<List<TutorFeedback>> getFeedbacks(String tutorId) async {
    List<TutorFeedback> feedbacks = await tutorApiClient.getFeedbacks(tutorId);
    return feedbacks;
  }
}
