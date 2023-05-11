import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
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
  var joinAsAnon = false.obs;

  ProfileController profileController = Get.find();

  Future<Map<String, dynamic>> createGroup(
      {required String groupName,
      required String desc,
      required String groupType,
      String? img,
      String? imgType,
      String? groupId}) async {
    isLoading.value = true;
    Map<String, dynamic> body = img != null
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
          };
    print(body);
    print(groupId);
    Map<String, dynamic> map = groupId == null
        ? await Network.makePostRequestWithToken(
                url: APIConstants.api + '/api/v1/group', body: body)
            .onError((error, stackTrace) {
            print(error);
            return {};
          })
        : await Network.makePutRequestWithToken(
                url: APIConstants.api + '/api/v1/group?groupId=$groupId',
                body: body)
            .onError((error, stackTrace) {
            print(error);
            return {};
          });
    log(map.toString());
    SolhSnackbar.success("Success", map["message"],
        duration: Duration(seconds: 3));
    isLoading.value = false;
    return map;
    return {};
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
    print(list);

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

  Future<String> joinGroup({required String groupId, required isAnon}) async {
    isLoading.value = true;
    String success = '';
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/join-group',
        body: {
          'groupId': groupId,
          'userId': profileController.myProfileModel.value.body!.user!.id!,
          'anonymous': isAnon.toString()
        }).onError((error, stackTrace) {
      print(error);
      success = 'error joining group';
      return {};
    });
    if (map['success'] == true) {
      success = map['message'];
    }

    isLoading.value = false;
    return success;
  }

  Future<String> exitGroup({required String groupId}) async {
    Map<String, dynamic> map = await Network.makeHttpDeleteRequestWithToken(
        url: APIConstants.api + '/api/exitGroup?groupId=$groupId',
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    String message = '';
    if (map['message'] == 'Exited from group') {
      message = map['message'];
    }
    return message;
  }
}
