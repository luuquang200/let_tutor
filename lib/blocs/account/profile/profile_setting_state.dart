import 'package:equatable/equatable.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/user/user.dart';

abstract class ProfileSettingState extends Equatable {
  const ProfileSettingState();

  @override
  List<Object> get props => [];
}

class ProfileSettingInitial extends ProfileSettingState {}

class ProfileSettingLoading extends ProfileSettingState {}

class ProfileSettingLoadSuccess extends ProfileSettingState {
  final User user;
  final bool isUpdatedSuccess;
  final bool isInvalidChange;
  final String message;
  final List<LearnTopic> learnTopics;
  final List<TestPreparation> testPreparations;
  final List<String> selectedLearnTopics;
  final List<String> selectedTestPreparations;

  const ProfileSettingLoadSuccess(
      this.user,
      this.learnTopics,
      this.testPreparations,
      this.selectedLearnTopics,
      this.selectedTestPreparations,
      {this.isUpdatedSuccess = false,
      this.isInvalidChange = false,
      this.message = ''});

  @override
  List<Object> get props => [
        user,
        isUpdatedSuccess,
        isInvalidChange,
        message,
        learnTopics,
        testPreparations,
        selectedLearnTopics,
        selectedTestPreparations
      ];

  ProfileSettingLoadSuccess copyWith(
      {User? user,
      bool? isUpdatedSuccess,
      bool? isInvalidChange,
      String? message,
      List<LearnTopic>? learnTopics,
      List<TestPreparation>? testPreparations,
      List<String>? selectedLearnTopics,
      List<String>? selectedTestPreparations}) {
    return ProfileSettingLoadSuccess(
      user ?? this.user,
      learnTopics ?? this.learnTopics,
      testPreparations ?? this.testPreparations,
      selectedLearnTopics ?? this.selectedLearnTopics,
      selectedTestPreparations ?? this.selectedTestPreparations,
      isUpdatedSuccess: isUpdatedSuccess ?? this.isUpdatedSuccess,
      isInvalidChange: isInvalidChange ?? this.isInvalidChange,
      message: message ?? this.message,
    );
  }
}

class ProfileSettingLoadFailure extends ProfileSettingState {
  final String message;

  const ProfileSettingLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
