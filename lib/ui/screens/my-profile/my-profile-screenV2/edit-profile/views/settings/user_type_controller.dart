import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/profile-setupV2/role-page/role_selection_screen_screen.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class UserTypeController extends GetxController {
  var selectedUserType = RoleType.Undefined.obs;
  ProfileController profileController = Get.find();
  var isUpdatingField = false.obs;

  Future<bool> updateUserProfile(Map<String, dynamic> body) async {
    try {
      isUpdatingField(true);
      var response = await Network.makePutRequestWithToken(
        url: '${APIConstants.api}/api/edit-user-details',
        body: body,
      );
      isUpdatingField(false);
      print('-------------');
      if (response["success"]) {
        print('-----------++++--');
        profileController.myProfileModel.value =
            MyProfileModel.fromJson(response);
        return true;
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        return false;
      }
    } catch (e) {
      print('-------fsfsfs----++++--');
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      return false;
    }
  }
}
