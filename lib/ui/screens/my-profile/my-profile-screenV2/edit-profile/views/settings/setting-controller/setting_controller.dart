import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/constants/org_only_setting.dart';

class SettingController extends GetxController {
  var orgOnly = false.obs;
  var isChangingPin = false.obs;

  void changeOrgOnlySetting(bool flag) {
    orgOnly.value = flag;

    OrgOnlySetting.setOrgOnly(flag);
  }

  Future<(bool, String)> changeMpin(String currentPin, String newPin) async {
    isChangingPin(true);
    try {
      bool changePinStatus = false;
      var response = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/change-mpin',
          body: {"currentMpin": currentPin, "newMpin": newPin});
      log(response.toString());
      if (response['success']) {
        changePinStatus = response['success'];
      }
      isChangingPin(false);
      return (changePinStatus, response['message'].toString());
    } catch (e) {
      isChangingPin(false);
      rethrow;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    var response = await OrgOnlySetting.getOrgOnly();
    if (response != null) {
      orgOnly.value = response;
    }
    super.onInit();
  }
}
