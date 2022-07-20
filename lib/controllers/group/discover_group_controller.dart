import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/services/network/network.dart';

class DiscoverGroupController extends GetxController {
  var createdGroupModel = GetGroupResponseModel().obs;
  var joinedGroupModel = GetGroupResponseModel().obs;
  var discoveredGroupModel = GetGroupResponseModel().obs;
  var groupDetail = GroupList().obs;
  var isLoading = false.obs;
  var isDeletingGroup = false.obs;

  @override
  void onInit() {
    getCreatedGroups();
    getJoinedGroups();
    getDiscoverGroups();
    super.onInit();
  }

  Future<void> getCreatedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/created-groups');
    if (map['success']) {
      createdGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }

  Future<void> getJoinedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/joined-groups');
    if (map['success']) {
      joinedGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }

  Future<void> getDiscoverGroups() async {
    Map<String, dynamic> map =
        await Network.makeGetRequestWithToken('${APIConstants.api}/api/group');
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

  Future<void> getGroupDetail(String groupId) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/group/$groupId');

    if (map['success']) {
      groupDetail.value = GroupList.fromJson(map['groupList'][0]);
    }
    isLoading.value = false;
  }
}
