import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/constants/app_rating_status.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class BottomNavigatorController extends GetxController {
  var isDrawerOpen = false.obs;
  PageController pageController = PageController(keepPage: true);

  var activeIndex = 0.obs;
  var givenStars = 0.obs;
  var feedbackTextEditingController = TextEditingController();
  var isSubmittingFeedback = false.obs;
  bool shouldShowFeedbackForm = false;

  Future<void> submitRating(Map<String, dynamic> body) async {
    isSubmittingFeedback(true);
    try {
      var response = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/custom/create-feedback', body: body);
      log(response.toString());
      if (response['success']) {
        SolhSnackbar.success('Success', "Feedback added successfully");
      }
    } catch (e) {
      throw (e);
    }
    isSubmittingFeedback(false);
  }

  Future<void> getFeedbackStatus() async {
    try {
      Future.delayed(Duration(seconds: 2), () async {
        var response = await Network.makeGetRequestWithToken(
            '${APIConstants.api}/api/custom/get-feedback');

        if (response['success']) {
          AppRatingStatus.appRatingStatus = response['status'];
        }
        await showRatingForm();
      });
    } catch (e) {
      throw (e);
    }
  }

  Future<void> showRatingForm() async {
    if (AppRatingStatus.appRatingStatus == false &&
        await AppRatingStatus.shouldShowRatingReminder()) {
      shouldShowFeedbackForm = true;
    } else {
      shouldShowFeedbackForm = false;
    }
    log('${AppRatingStatus.appRatingStatus} ${await AppRatingStatus.shouldShowRatingReminder()}',
        name: "AppRatingStatus");
    if (await AppRatingStatus.shouldShowRatingReminder()) {
      AppRatingStatus.setRatingReminderTime();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getFeedbackStatus();

    super.onInit();
  }
}
