import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class AnonController extends GetxController {
  var isNameTaken = false.obs;
  var isNormalNameTaken = false.obs;
  var userName = "".obs;
  var avtarImageUrl = "".obs;
  var avtarType = "".obs;
  var isLoading = false.obs;

  Future<void> checkIfUserNameTaken(String name) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/userName-taken',
        body: {'userName': name});
    isNameTaken.value = !map['flag'];
  }

  Future<void> checkIfNormalUserNameTaken(String name) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/is-username-taken',
        body: {'first_name': name});
    isNormalNameTaken.value = map['body']['isCreated'];
  }

  Future<String?> createAnonProfile() async {
    isLoading.value = true;
    debugPrint(avtarImageUrl.value);
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/anonymous',
        body: {
          'userName': userName.value,
          'profilePicture': avtarImageUrl.value,
          'profilePictureType': avtarType.value,
        });
    isLoading.value = false;
    debugPrint('trying to create anon profile $map');
    if (map['success']) {
      return map['message'];
    }
    return null;
  }
}
