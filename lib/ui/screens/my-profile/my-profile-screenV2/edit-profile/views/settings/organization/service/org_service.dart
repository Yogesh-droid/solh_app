import 'package:solh/constants/api.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/services/network/network.dart';

class OrgService {
  Future<MyProfileModel> deleteOrgService(String id) async {
    try {
      final response = await Network.makePutRequestWithToken(
          url: '${APIConstants.api}/api/delete-user-organisation',
          body: {'organisation': id});

      if (response['success']) {
        return MyProfileModel.fromJson(response);
      } else {
        throw (response);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<MyProfileModel> updateOrgTeam(
      {required String userOrgId, required String selectedOptionId}) async {
    try {
      final response = await Network.makePutRequestWithToken(
          url: '${APIConstants.api}/api/update-user-option',
          body: {
            "userOrgId": userOrgId,
            "selectedOptionId": selectedOptionId,
          });
      if (response['success']) {
        return MyProfileModel.fromJson(response);
      } else {
        throw (response);
      }
    } catch (e) {
      throw (e);
    }
  }
}
