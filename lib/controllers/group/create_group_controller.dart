import 'dart:convert';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/services/utility.dart';
import '../../bloc/user-bloc.dart';
import '../../constants/api.dart';
import '../../services/network/network.dart';
import 'package:http/http.dart' as http;

class CreateGroupController extends GetxController {
  var path = ''.obs;
  var tagList = [].obs;
  var selectedMembersIndex = [].obs;
  var selectedMembers = [];
  var isLoading = false.obs;

  Future<Map<String, dynamic>> createGroup(
      {required String groupName,
      required String desc,
      required String groupType,
      String? img,
      String? imgType}) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
            url: APIConstants.api + '/api/group',
            body: img != null
                ? {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupMediaUrl': img,
                    'groupMediaType': imgType,
                    'groupTags': tagList.value.join(',')
                  }
                : {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupTags': tagList.value.join(',')
                  })
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    isLoading.value = false;
    return map;
  }

  Future<Map<String, dynamic>> addMembers({
    required String groupId,
  }) async {
    List<String> list = [];
    selectedMembers.forEach((element) {
      list.add("${element}");
    });
    http.post(Uri.parse('${APIConstants.api}/api/sendInvite'),
        body: jsonEncode({
          'groupId': groupId,
          'userId': list,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
        }).then((value) {
      print(value.body);
    });

    return {};
  }

  Future<void> updateGroupDetails(
      {required String groupId,
      required String groupName,
      required String desc,
      required String groupType,
      String? img,
      String? imgType}) async {
    isLoading.value = true;
    await Network.makePutRequestWithToken(
            url: APIConstants.api + '/api/group?groupId=${groupId}',
            body: img != null
                ? {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupMediaUrl': img,
                    'groupMediaType': imgType,
                    'groupTags': tagList.value.join(',')
                  }
                : {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupTags': tagList.value.join(',')
                  })
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    isLoading.value = false;
  }

  Future<Map<String, dynamic>> joinGroup({required String groupId}) async {
    isLoading.value = true;
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
            url: APIConstants.api + '/api/join-group',
            body: {'groupId': groupId, 'userId': userBlocNetwork.id})
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (map['success'] == true) {
      Utility.showToast(map['message']);
    }
    isLoading.value = false;
    return map;
  }
}
