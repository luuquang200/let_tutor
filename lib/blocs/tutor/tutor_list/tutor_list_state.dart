import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/schedule/booked_schedule.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';

abstract class TutorListState extends Equatable {
  const TutorListState();
}

class TutorListInitial extends TutorListState {
  @override
  List<Object> get props => [];
}

class TutorListLoading extends TutorListState {
  @override
  List<Object> get props => [];
}

class TutorListSuccess extends TutorListState {
  final List<Tutor> tutors;
  final Map<String, dynamic> filters;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final bool isReset;
  final String selectedNationality;
  final BookedSchedule upcomingSchedule;
  final int totalCall;

  const TutorListSuccess(
      this.tutors,
      this.filters,
      this.learnTopics,
      this.testPreparations,
      this.isReset,
      this.selectedNationality,
      this.upcomingSchedule,
      this.totalCall);

  @override
  List<Object> get props => [
        tutors,
        filters,
        learnTopics,
        testPreparations,
        isReset,
        selectedNationality,
        upcomingSchedule,
        totalCall
      ];

  TutorListSuccess copyWith(
      {List<Tutor>? tutors,
      Map<String, dynamic>? filters,
      List<LearnTopic>? learnTopics,
      List<TestPreparation>? testPreparations,
      bool? isReset,
      String? selectedNationality,
      BookedSchedule? upcomingSchedule,
      int? totalCall}) {
    return TutorListSuccess(
        tutors ?? this.tutors,
        filters ?? this.filters,
        learnTopics ?? this.learnTopics,
        testPreparations ?? this.testPreparations,
        isReset ?? this.isReset,
        selectedNationality ?? this.selectedNationality,
        upcomingSchedule ?? this.upcomingSchedule,
        totalCall ?? this.totalCall);
  }
}

class TutorListFailure extends TutorListState {
  final String error;

  const TutorListFailure(this.error);

  @override
  List<Object> get props => [error];
}
