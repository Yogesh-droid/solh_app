import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/group/group_detail_model.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/group/homepage_group_model.dart';
import 'package:solh/services/network/network.dart';

class DiscoverGroupController extends GetxController {
  var createdGroupModel = GetGroupResponseModel().obs;
  var joinedGroupModel = GetGroupResponseModel().obs;
  var discoveredGroupModel = GetGroupResponseModel().obs;
  var groupDetailModel = GroupDetailModel().obs;
  var homepageGroupModel = HomepageGroupModel().obs;
  bool disableNextPageSetting = false;
  List<String> groupsShownOnHome =
      []; ////  groups shown on home screen created + joined groups// used to find index of selected group
  ////  So that we can animate the controller to its partcular position
  TabController? tabController;
  var isLoading = false.obs;
  var isLoadingMoreGroupMembers = false.obs;
  var isDeletingGroup = false.obs;
  var loadingDiscoverGroups = false.obs;
  var loadingJoinedGroups = false.obs;
  var loadingCreatedGroups = false.obs;
  int? nextPage = 1; // used for discover groups
  int? createGroupNextPage = 1; // used for create groups
  int? joinedGroupNextPage = 1; // used for joined groups
  var isSharingLink = false.obs;
  var isHomePageGroupLoading = false.obs;

  @override
  void onInit() {
    getJoinedGroups();
    getCreatedGroups();
    getDiscoverGroups();
    getHomePageGroup();
    super.onInit();
  }

  Future<void> getCreatedGroups() async {
    if (createGroupNextPage != null) {
      loadingCreatedGroups.value = true;
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/created-groupsv2?pageNumber=${createGroupNextPage}&limit=10');
      loadingCreatedGroups.value = false;
      if (map['success']) {
        GetGroupResponseModel groupResponseModel =
            GetGroupResponseModel.fromJson(map);
        if (createGroupNextPage == 1) {
          createdGroupModel.value = groupResponseModel;
        } else {
          createdGroupModel.value.groupList!
              .addAll(groupResponseModel.groupList!);
          createdGroupModel.value.pages!.next = groupResponseModel.pages!.next;
          createdGroupModel.refresh();
        }
        createGroupNextPage = createdGroupModel.value.pages!.next;
      }
    }
  }

  Future<void> getJoinedGroups() async {
    if (joinedGroupNextPage != null || disableNextPageSetting) {
      loadingJoinedGroups.value = true;
      joinedGroupModel.value.groupList?.clear();
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/joined-groupsv2?pageNumber=$joinedGroupNextPage&limit=10');
      loadingJoinedGroups.value = false;
      if (map['success']) {
        GetGroupResponseModel groupResponseModel =
            GetGroupResponseModel.fromJson(map);
        if (joinedGroupNextPage == 1) {
          joinedGroupModel.value = groupResponseModel;
        } else {
          joinedGroupModel.value.groupList!
              .addAll(groupResponseModel.groupList!);
          joinedGroupModel.value.pages!.next = groupResponseModel.pages!.next;
          joinedGroupModel.refresh();
        }
        joinedGroupNextPage = joinedGroupModel.value.pages!.next;
      }
    }
  }

  Future<void> getDiscoverGroups() async {
    if (nextPage != null) {
      loadingDiscoverGroups.value = true;
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/groupv2?pageNumber=${nextPage}&limit=10');
      loadingDiscoverGroups.value = false;
      if (map['success']) {
        GetGroupResponseModel groupResponseModel =
            GetGroupResponseModel.fromJson(map);
        if (nextPage == 1) {
          discoveredGroupModel.value = groupResponseModel;
        } else {
          discoveredGroupModel.value.groupList!
              .addAll(groupResponseModel.groupList!);
          discoveredGroupModel.value.pages!.next =
              groupResponseModel.pages!.next;
          discoveredGroupModel.refresh();
        }

        nextPage = discoveredGroupModel.value.pages!.next;
      }
    }
  }

  Future<void> deleteGroups(String groupId) async {
    isDeletingGroup.value = true;
    await Network.makeHttpDeleteRequestWithToken(
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

  Future<void> getHomePageGroup() async {
    isHomePageGroupLoading(true);
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/homepage-group');
      if (map['success']) {
        homepageGroupModel.value = HomepageGroupModel.fromJson(map);
      }
    } catch (e) {
      throw (e);
    }
    isHomePageGroupLoading(false);
  }
}
