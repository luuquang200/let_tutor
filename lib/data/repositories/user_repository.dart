import 'package:let_tutor/data/network/apis/user_api_client.dart';

class UserRepository {
  final userApiClient = UserApiClient();

  // get total call
  Future<int> getTotalCall() async {
    return await userApiClient.getTotalCall();
  }
}
