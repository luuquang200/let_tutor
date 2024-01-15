import 'package:let_tutor/data/models/user/user.dart';
import 'package:let_tutor/data/network/apis/user_api_client.dart';

class UserRepository {
  final userApiClient = UserApiClient();

  // get total call
  Future<int> getTotalCall() async {
    return await userApiClient.getTotalCall();
  }

  // get user by id
  Future<User> getUserInformation() async {
    return await userApiClient.getUserInformation();
  }

  Future<User> changeAvatar({required String avatarUrl}) async {
    return await userApiClient.changeAvatar(avatarPath: avatarUrl);
  }

  // saveProfileSetting({required String name, required String country, required String birthday, required String level, required String studySchedule, required List<String> selectedLearnTopics, required List<String> selectedTestPreparations}) {}
  Future<User> saveProfileSetting(
      {required String name,
      required String country,
      required String birthday,
      required String level,
      required String studySchedule,
      required List<String> selectedLearnTopics,
      required List<String> selectedTestPreparations}) async {
    return await userApiClient.saveProfileSetting(
        name: name,
        country: country,
        birthday: birthday,
        level: level,
        studySchedule: studySchedule,
        selectedLearnTopics: selectedLearnTopics,
        selectedTestPreparations: selectedTestPreparations);
  }
}
