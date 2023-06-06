import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/group/group_detail_model.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/model/group/get_group_response_model.dart' as groupList;

class DiscoverGroupController extends GetxController {
  var createdGroupModel = GetGroupResponseModel().obs;
  var joinedGroupModel = GetGroupResponseModel().obs;
  var discoveredGroupModel = GetGroupResponseModel().obs;
  var groupDetailModel = GroupDetailModel().obs;
  List<String> groupsShownOnHome =
      []; ////  groups shown on home screen created + joined groups// used to find index of selected group
  ////  So that we can animate the controller to its partcular position
  //var groupDetail = GroupList().obs;
  TabController? tabController;
  var isLoading = false.obs;
  var isLoadingMoreGroupMembers = false.obs;
  var isDeletingGroup = false.obs;

  @override
  void onInit() {
    getJoinedGroups();
    getCreatedGroups();
    getDiscoverGroups();
    super.onInit();
  }

  Future<void> getCreatedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/created-groupsv1');
    if (map['success']) {
      createdGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
    // createdGroupModel.value.groupList!.forEach((group) {
    //   groupsShownOnHome.add(group.id!);
    // });
  }

  Future<void> getJoinedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/joined-groupsv1?pageNumber=1&limit=10');
    if (map['success']) {
      joinedGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
    // joinedGroupModel.value.groupList!.forEach((group) {
    //   groupsShownOnHome.add(group.id!);
    // });
  }

  Future<void> getDiscoverGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/groupv1?pageNumber=1&limit=20');
    if (map['success']) {
      discoveredGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }

  Future<void> deleteGroups(String groupId) async {
    isDeletingGroup.value = true;
    Map<String, dynamic> map = await Network.makeHttpDeleteRequestWithToken(
        url: '${APIConstants.api}/api/group?groupId=$groupId', body: {});
    getCreatedGroups();
    getJoinedGroups();
    isDeletingGroup.value = false;
  }

  Future<void> getGroupDetail(String groupId, int pageNo) async {
    log(groupId);
    pageNo > 1 ? isLoadingMoreGroupMembers(true) : isLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/groupv1/${groupId}?pageNumber=$pageNo&limit=50');

      if (map['success'] && pageNo == 1) {
        print('This is map $map');
        groupDetailModel.value = GroupDetailModel.fromJson(map);
      } else if (pageNo > 1) {
        GroupDetailModel groupDetailModelMore = GroupDetailModel.fromJson(map);

        groupDetailModelMore.groupList!.groupMembers!.forEach((element) {
          groupDetailModel.value.groupList!.groupMembers!.add(element);
        });

        groupDetailModel.refresh();
      }
      isLoading(false);
      isLoadingMoreGroupMembers(false);
    } catch (e) {
      log(e.toString());
      throw (e);
    }

    isLoading.value = false;
  }
}
