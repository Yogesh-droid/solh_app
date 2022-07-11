import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import '../../model/goal-setting/goal_cat_model.dart';
import '../../model/goal-setting/goal_sub_cat_model.dart' as subCat;
import 'package:http/http.dart' as http;
import '../../model/goal-setting/personal_goal_model.dart';
import '../../model/goal-setting/sample_goals_model.dart';

class GoalSettingController extends GetxController {
  var completedGoals = 0.obs;
  var goalsCatModel = GoalCatModel().obs;
  var SubCatModel = subCat.GetSubCatModel().obs;
  var selectedSubCat = subCat.Categories().obs;
  var pesonalGoalModel = PersonalGoalModel().obs;
  var sampleGoalModel = SampleGoalsModel().obs;
  var noOfTasks = 1.obs;
  var task = [].obs;
  var isExpanded = ''.obs;
  var isExpandedPanelExpanded = false.obs;
  var expandedIndex = ''.obs;
  var noOfGoalsCompleted = 0.obs;
  var noOfGoals = 0.obs;

  /// loading state

  var loading = false.obs;
  var loadingCat = false.obs;
  var isPersonalGoalLoading = false.obs;
  var isSampleGoalLoading = false.obs;
  var isSavingGoal = false.obs;
  var isUpdateGoal = false.obs;
  var isDeletingGoal = false.obs;

  Future<void> getPersonalGoals() async {
    Map<String, dynamic> map;
    isPersonalGoalLoading.value = true;
    map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/personal-goals');
    if (map['success']) {
      pesonalGoalModel.value = PersonalGoalModel.fromJson(map);
      noOfGoals.value = pesonalGoalModel.value.milestone!;
      noOfGoalsCompleted.value = pesonalGoalModel.value.milestoneReached!;
    }
    isPersonalGoalLoading.value = false;
  }

  Future<void> getSampleGoal(String id) async {
    isSampleGoalLoading.value = true;
    Map<String, dynamic> map;
    map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/sample-goals?goal=$id');
    if (map['success']) {
      sampleGoalModel.value = SampleGoalsModel.fromJson(map);
    }
    isSampleGoalLoading.value = false;
  }

  Future<void> getGoalsCat() async {
    loadingCat.value = true;
    Map<String, dynamic> map;

    map = await Network.makeGetRequestWithToken(
      '${APIConstants.api}/api/goal-categories',
    );

    if (map['success']) {
      goalsCatModel.value = GoalCatModel.fromJson(map);
    }
    loadingCat.value = false;
  }

  Future<void> getSubCat(String id) async {
    loading.value = true;
    Map<String, dynamic> map;

    map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/sub-categories?parent=${id}');

    if (map['success']) {
      SubCatModel.value = subCat.GetSubCatModel.fromJson(map);
    }
    loading.value = false;
  }

  void addTask() {
    task.value.add({TextEditingController(): '1'});
    task.refresh();
  }

  Future<void> saveGoal(
      {String? goalName,
      required String goalType,
      String? imageUrl,
      String? goalId,
      String? goalCatId}) async {
    List activity = [];
    isSavingGoal.value = true;
    if (goalType == 'custom') {
      task.value.forEach((element) {
        activity.add({
          'task': element.keys.first.text,
          'occurence': element.values.first,
        });
      });
      String body = jsonEncode({
        "goalImage": imageUrl,
        "goalType": goalType,
        "goalCategory": selectedSubCat.value.sId,
        "goalName": goalName,
        "activity": activity
      });
      print(body);
      print(userBlocNetwork.getSessionCookie);
      print('${APIConstants.api}/api/personal-goals');

      await http.post(
        Uri.parse('${APIConstants.api}/api/personal-goals'),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
        },
      ).then((response) {
        print(response.body);
      });
    } else {
      Map<String, dynamic> map;

      print('adding Sample Goal');

      map = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/personal-goals',
          body: {
            "goalType": "sample",
            "goalCategory": goalCatId,
            "goalId": goalId
          });
    }
    isSavingGoal.value = false;
    getPersonalGoals();
  }

  Future<void> deleteGoal(String id) async {
    Map<String, dynamic> map;
    isDeletingGoal.value = true;

    map = await Network.makeHttpDeleteRequestWithToken(
        body: {}, url: '${APIConstants.api}/api/goal?goalId=$id');
    isDeletingGoal.value = false;
    getPersonalGoals();
  }

  Future<void> updateActivity(String goalId, String activityId) async {
    Map<String, dynamic> map;
    isUpdateGoal.value = true;
    map = await Network.makePutRequestWithToken(
        url: '${APIConstants.api}/api/activity-status?goal=$goalId',
        body: {
          'activity': activityId,
        });
    print(map);
    pesonalGoalModel.value.goalList!.forEach((element) {
      if (element.sId == goalId) {
        element.activity!.forEach((element) {
          if (element.sId == activityId) {
            element.isComplete = true;
          }
        });
        if (element.activity!.every((element) => element.isComplete ?? true)) {
          pesonalGoalModel.value.milestoneReached! + 1;
          pesonalGoalModel.refresh();
          noOfGoalsCompleted.value = noOfGoalsCompleted.value + 1;
        }
      }
    });
    print(map);
    if (map['success']) {
      pesonalGoalModel.refresh();
    }
    isUpdateGoal.value = false;
  }

  @override
  void onInit() {
    getPersonalGoals();
    getGoalsCat();
    task.value.add({TextEditingController(): '1'});
    super.onInit();
  }
}
