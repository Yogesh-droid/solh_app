import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/profile-setupV2/need-support-on/need-support-on-model/need_support_on_model.dart';
import 'package:solh/ui/screens/profile-setupV2/need-support-on/need-support-on-service/need_support_on_service.dart';

class ChatAnonController extends GetxController {
  var isLoadingIssues = false.obs;
  var needSupportOnModel = NeedSupportOnModel().obs;
  NeedSupportOnService needSupportOnService = NeedSupportOnService();
  var selectedOtherIssues = [].obs;
  var selectedIsses = [].obs;
  var showOtherissueField = false.obs;
  TextEditingController otherIssueTextField = TextEditingController();

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
