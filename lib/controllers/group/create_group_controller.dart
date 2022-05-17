import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../bloc/user-bloc.dart';
import '../../constants/api.dart';
import '../../services/network/network.dart';
import 'package:http/http.dart' as http;

class CreateGroupController extends GetxController {
  var path = ''.obs;
  var tagList = [].obs;
  var selectedMembersIndex = [].obs;
  var selectedMembers = [];

  Future<Map<String, dynamic>> createGroup(
      {required String groupName,
      required String desc,
      required String groupType,
      String? img,
      String? imgType}) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
            url: APIConstants.api + '/api/group',
            body: img != null
                ? {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupMediaUrl': img,
                    'groupMediaType': imgType
                  }
                : {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                  })
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    return map;
  }

  Future<Map<String, dynamic>> addMembers({
    required String groupId,
  }) async {
    List<String> list = [];
    selectedMembers.forEach((element) {
      list.add("${element}");
    });

    // Map<String, dynamic> map = await Network.makePostRequestWithToken(
    //         url: APIConstants.api + '/api/sendInvite',
    //         body: {
    //           'groupId': groupId,
    //           'userId': list,
    //         },
    //         isEncoded: true)
    //     .onError((error, stackTrace) {
    //   print(error);
    //   return {};
    // });

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

  Future<Map<String, dynamic>> joinGroup({required String groupId}) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/join-group',
        body: {
          'groupId': groupId,
          'userId': FirebaseAuth.instance.currentUser!.uid
        }).onError((error, stackTrace) {
      print(error);
      return {};
    });
    return map;
  }
}
