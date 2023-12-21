import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/tutors/category.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/tutors/tutor.dart';

abstract class TutorDetailState extends Equatable {}

class TutorDetailInitial extends TutorDetailState {
  @override
  List<Object> get props => [];
}

class TutorDetailLoading extends TutorDetailState {
  @override
  List<Object> get props => [];
}

class TutorDetailSuccess extends TutorDetailState {
  final Tutor tutor;
  final DateTime updated;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final List<MyCategory> categories;
  final bool reportSuccess;
  final bool updateFavoriteSuccess;

  TutorDetailSuccess(this.tutor, this.updated, this.learnTopics,
      this.testPreparations, this.categories,
      {this.reportSuccess = false, this.updateFavoriteSuccess = false});

  @override
  List<Object> get props => [
        tutor,
        updated,
        learnTopics,
        testPreparations,
        categories,
        reportSuccess,
        updateFavoriteSuccess,
      ];

  TutorDetailSuccess copyWith({
    Tutor? tutor,
    DateTime? lastUpdated,
    List<LearnTopic>? learnTopics,
    List<TestPreparation>? testPreparations,
    List<MyCategory>? categories,
    bool? reportSuccess,
    bool? updateFavoriteSuccess,
  }) {
    return TutorDetailSuccess(
      tutor ?? this.tutor,
      lastUpdated ?? updated,
      learnTopics ?? this.learnTopics,
      testPreparations ?? this.testPreparations,
      categories ?? this.categories,
      reportSuccess: reportSuccess ?? this.reportSuccess,
      updateFavoriteSuccess:
          updateFavoriteSuccess ?? this.updateFavoriteSuccess,
    );
  }
}

class TutorDetailFailure extends TutorDetailState {
  final String error;

  TutorDetailFailure(this.error);

  @override
  List<Object> get props => [error];
}
