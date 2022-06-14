import 'package:solh/constants/api.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/network/network.dart';

class UserProfile {
  static Future<UserModel> fetchUserProfile(String sId) async {
    var response = await Network.makeHttpGetRequestWithToken(
        "${APIConstants.api}/api/get-user-profile-details/$sId");
    print('user profile is fetched successfully $response');
    print(response);
    return UserModel.fromJson(response["user"]);
  }
}
