import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_event.dart';
import 'package:let_tutor/blocs/account/profile/profile_setting_state.dart';
import 'package:let_tutor/data/models/tutors/learn_topic.dart';
import 'package:let_tutor/data/models/tutors/test_preparation.dart';
import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/repositories/tutor_repository.dart';
import 'package:let_tutor/data/repositories/user_repository.dart';

class ProfileSettingBloc
    extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  final UserRepository userRepository;
  final TutorRepository tutorRepository;
  late List<LearnTopic> learnTopics;
  late List<TestPreparation> testPreparations;
  late List<String> selectedLearnTopics;
  late List<String> selectedTestPreparations;

  ProfileSettingBloc(
      {required this.userRepository, required this.tutorRepository})
      : super(ProfileSettingInitial()) {
    on<GetProfileSettingPage>(_onGetProfileSettingPage);
    on<ChangeAvatar>(_onChangeAvatar);
    on<SaveProfileSetting>(_onSaveProfileSetting);
  }

  Future<void> _onGetProfileSettingPage(
      GetProfileSettingPage event, Emitter<ProfileSettingState> emit) async {
    emit(ProfileSettingLoading());
    selectedLearnTopics = [];
    selectedTestPreparations = [];
    try {
      User user = await userRepository.getUserInformation();
      learnTopics = await tutorRepository.getLearnTopic();
      testPreparations = await tutorRepository.getTestPreparation();

      user.learnTopics?.forEach((element) {
        selectedLearnTopics.add(element.id.toString());
      });

      user.testPreparations?.forEach((element) {
        selectedTestPreparations.add(element['id'].toString());
      });

      emit(ProfileSettingLoadSuccess(user, learnTopics, testPreparations,
          selectedLearnTopics, selectedTestPreparations));
    } catch (e) {
      emit(ProfileSettingLoadFailure(e.toString()));
    }
  }

  Future<void> _onChangeAvatar(
      ChangeAvatar event, Emitter<ProfileSettingState> emit) async {
    var currentState = state;
    emit(ProfileSettingLoading());
    try {
      User user = await userRepository.changeAvatar(avatarUrl: event.avatarUrl);

      if (currentState is ProfileSettingLoadSuccess) {
        emit(currentState.copyWith(
          user: user,
          isUpdatedSuccess: true,
        ));
      }
    } catch (e) {
      emit(ProfileSettingLoadFailure(e.toString()));
    }
  }

  Future<void> _onSaveProfileSetting(
      SaveProfileSetting event, Emitter<ProfileSettingState> emit) async {
    var currentState = state;

    emit(ProfileSettingLoading());
    try {
      if (currentState is ProfileSettingLoadSuccess) {
        if (event.name.isEmpty) {
          emit(currentState.copyWith(
            isInvalidChange: true,
            isUpdatedSuccess: false,
            message: 'Name is required',
          ));
          return;
        }

        if (event.selectedLearnTopics.isEmpty &&
            event.selectedTestPreparations.isEmpty) {
          emit(currentState.copyWith(
            isInvalidChange: true,
            isUpdatedSuccess: false,
            message: 'At least one subject is required',
          ));
          return;
        }

        User user = await userRepository.saveProfileSetting(
            name: event.name,
            country: event.country,
            birthday: event.birthday,
            level: event.level,
            studySchedule: event.studySchedule,
            selectedLearnTopics: event.selectedLearnTopics,
            selectedTestPreparations: event.selectedTestPreparations);
        emit(currentState.copyWith(
          user: user,
          isUpdatedSuccess: true,
        ));
      }
    } catch (e) {
      emit(ProfileSettingLoadFailure(e.toString()));
    }
  }
}
