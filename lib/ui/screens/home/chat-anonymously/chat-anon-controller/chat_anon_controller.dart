import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-model/chat_anon_model.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-service/chat_anon_service.dart';
import 'package:solh/ui/screens/profile-setupV2/need-support-on/need-support-on-model/need_support_on_model.dart';
import 'package:solh/ui/screens/profile-setupV2/need-support-on/need-support-on-service/need_support_on_service.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class ChatAnonController extends GetxController {
  var isLoadingIssues = false.obs;
  var isFeatchingUser = false.obs;
  var isPostingFeedback = false.obs;

  var needSupportOnModel = NeedSupportOnModel().obs;
  NeedSupportOnService needSupportOnService = NeedSupportOnService();
  var chatAnonModel = ChatAnonModel().obs;
  var selectedOtherIssues = [].obs;

  var anonSId = ''.obs;
  var selectedIsses = [].obs;
  var selectedIssuesName = ''.obs;
  var selectedOtherIssuesName = ''.obs;
  var showOtherissueField = false.obs;
  TextEditingController otherIssueTextField = TextEditingController();
  TextEditingController feedbackTextField = TextEditingController();

  ChatAnonService chatAnonService = ChatAnonService();

  Future<void> getNeedSupportOnIssues() async {
    try {
      isLoadingIssues(true);
      NeedSupportOnModel response =
          await needSupportOnService.getSupportIssues();
      if (response.success! && response.success != null) {
        needSupportOnModel.value = response;
        isLoadingIssues(false);
      } else {
        isLoadingIssues(false);
      }
    } catch (e) {
      isLoadingIssues(false);
      throw e;
    }
  }

  Future<bool> getVolunteerController() async {
    try {
      isFeatchingUser(true);
      ChatAnonModel response = await chatAnonService.getVolunteer();
      if (response.success!) {
        chatAnonModel.value = response;
        isFeatchingUser(false);
        return true;
      } else {
        isFeatchingUser(false);
        return false;
      }
    } catch (e) {
      isFeatchingUser(false);
      throw e;
    }
  }

  Future<bool> postFeedbackController(Map<String, dynamic> body) async {
    try {
      isPostingFeedback(true);
      Map<String, dynamic> response = await chatAnonService.postFeedback(body);
      if (response['success']) {
        isPostingFeedback(false);
        return true;
      } else {
        isPostingFeedback(false);
        return false;
      }
    } catch (e) {
      isPostingFeedback(false);
      SolhSnackbar.error('Error', 'Something went wrong');
      throw e;
    }
  }
}
