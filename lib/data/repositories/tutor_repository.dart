
import 'dart:developer';
import 'package:let_tutor/data/models/tutors/category.dart';
import 'package:let_tutor/data/models/tutors/feedback.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';
import 'package:let_tutor/data/models/tutors/tutor_schedule.dart';
import 'package:let_tutor/data/models/tutors/tutor_search_result.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/network/apis/schedule_api_client.dart';
import 'package:let_tutor/data/network/apis/tutor_api_client.dart';
import 'package:let_tutor/data/network/apis/user_api_client.dart';

class TutorRepository {
  final tutorApiClient = TutorApiClient();
  final userApiClient = UserApiClient();
  final scheduleApiClient = ScheduleApiClient();

  Future<List<Tutor>> getTutors(  ) async {
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
  Future<TutorSearchResult> searchTutor(
      Map<String, dynamic> filters, int page, int perPage, String? name) async {
    TutorSearchResult result =
        await tutorApiClient.searchTutor(filters, page, perPage, name);
    return result;
  }

  // get tutor by id
  Future<Tutor> getTutorById(String id) async {
    Tutor tutor = await tutorApiClient.getTutorById(id);
    return tutor;
  }

  Future<List<TutorSchedule>> getScheduleOfTutor(String tutorId) async {
    List<TutorSchedule> tutorSchedules =
        await tutorApiClient.getScheduleOfTutor(tutorId);

    log('Schedule: $tutorSchedules');
    for (var tutorSchedule in tutorSchedules) {
      log('Schedule: ${tutorSchedule.scheduleDetails}');
    }

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

  // get user by id
  Future<User> getUser(String id) async {
    User user = await userApiClient.getUserById(id);
    return user;
  }

  // book tutor
  Future<void> bookTutor(String scheduleId, String note) async {
    try {
      return await tutorApiClient.bookTutor(scheduleId, note);
    } catch (e) {
      log('Error from book tutor reposiory: $e');
      log('$e');
      rethrow;
    }
  }
}
