import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/need-support-on/need-support-on-model/need_support_on_model.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/need-support-on/need-support-on-service/need_support_on_service.dart';
import 'package:solh/ui/screens/profile-setupV2/role-page/role_selection_screen_screen.dart';

import '../../../../widgets_constants/solh_snackbar.dart';

class ProfileSetupController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  var dobDate = DateTime.now().obs;

  var needSupportOnModel = NeedSupportOnModel().obs;
  NeedSupportOnService needSupportOnService = NeedSupportOnService();

  var isUpdatingField = false.obs;

  var isLoadingIssues = false.obs;

  ProfileController profileController = Get.find();

  var gender = ''.obs;

  var showGenderDropdown = false.obs;

  var selectedIsses = [].obs;
  var selectedOtherIssues = [].obs;

  var showOtherissueField = false.obs;

  var selectedRoleType = RoleType.Undefined.obs;

  var organisation = ''.obs;

  TextEditingController organisationNameController = TextEditingController();

  TextEditingController otherIssueTextField = TextEditingController();
  TextEditingController providerEmailController = TextEditingController();

  Future<bool> updateUserProfile(Map<String, dynamic> body) async {
    try {
      isUpdatingField(true);

      var response = await Network.makePutRequestWithToken(
        url: '${APIConstants.api}/api/edit-user-details',
        body: body,
      );
      debugPrint("response" + response.toString());

      if (response["success"]) {
        debugPrint("response" + response.toString());
        profileController.myProfileModel.value =
            MyProfileModel.fromJson(response);
        isUpdatingField(false);
        return true;
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        isUpdatingField(false);
        return false;
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      isUpdatingField(false);
      return false;
    }
  }

  Future<void> getNeedSupportOnIssues() async {
    try {
      isLoadingIssues(true);
      NeedSupportOnModel response =
          await needSupportOnService.getSupportIssues();
      if (response.success! && response.success != null) {
        needSupportOnModel.value = response;
        isLoadingIssues(false);
      }
    } catch (e) {
      throw e;
    }
  }
}
