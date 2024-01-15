import 'package:equatable/equatable.dart';

abstract class ProfileSettingEvent extends Equatable {
  const ProfileSettingEvent();

  @override
  List<Object> get props => [];
}

class GetProfileSettingPage extends ProfileSettingEvent {
  const GetProfileSettingPage();

  @override
  List<Object> get props => [];
}

class ChangeAvatar extends ProfileSettingEvent {
  const ChangeAvatar({required this.avatarUrl});

  final String avatarUrl;

  @override
  List<Object> get props => [avatarUrl];
}

class SaveProfileSetting extends ProfileSettingEvent {
  const SaveProfileSetting({
    required this.name,
    required this.country,
    required this.birthday,
    required this.level,
    required this.studySchedule,
    required this.selectedLearnTopics,
    required this.selectedTestPreparations,
  });

  final String name;
  final String country;
  final String birthday;
  final String level;
  final String studySchedule;
  final List<String> selectedLearnTopics;
  final List<String> selectedTestPreparations;

  @override
  List<Object> get props => [
        name,
        country,
        birthday,
        level,
        studySchedule,
        selectedLearnTopics,
        selectedTestPreparations
      ];
}
