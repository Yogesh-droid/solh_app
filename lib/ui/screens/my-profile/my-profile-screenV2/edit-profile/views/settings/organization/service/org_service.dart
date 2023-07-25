import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
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

  Future<void> updateOrgTeam(
      {required String userOrgId,
      required String selectedOptionId,
      required String type}) async {
    try {
      final response = await Network.makePutRequestWithToken(
          url: '${APIConstants.api}/api/update-user-option',
          body: {
            "userOrgId": userOrgId,
            "selectedOptionId": selectedOptionId,
            "type": type
          });
      if (response['success']) {
        await Get.find<ProfileController>().getMyProfile();
      } else {
        throw (response);
      }
    } catch (e) {
      throw (e);
    }
  }
}
