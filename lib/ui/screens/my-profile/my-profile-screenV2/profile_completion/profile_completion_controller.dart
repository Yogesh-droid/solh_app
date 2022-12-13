import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:http/http.dart' as http;

class ProfileCompletionController extends GetxController {
  var selectedConnection = [].obs;

  ProfileController profileController = Get.find();

  var imageUrl = ''.obs;
  var anonImageUrl = ''.obs;

  var currentCompletionPageIndex = 0;

  var isUpdatingField = false.obs;

  List uncompleteFields = [];

  var orgType = ''.obs;

  TextEditingController bioTextEditingController = TextEditingController();
  TextEditingController anonNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController orgNameTextEditingController = TextEditingController();
  TextEditingController sosMessageTextEditingController =
      TextEditingController();

  String getAppRoute(int pageIndexArray) {
    switch (pageIndexArray) {
      case 0:
        return AppRoutes.addAvatar;
      case 1:
        return AppRoutes.bio;
      case 2:
        return AppRoutes.anonymousProfile;
      case 3:
        return AppRoutes.addEmail;
      case 4:
        return AppRoutes.emergencyContact;
      case 5:
        return AppRoutes.partOfOrg;
      default:
        return AppRoutes.myProfile;
    }
  }

  int getPageFromIndex(String pagename) {
    switch (pagename) {
      case 'avatar':
        return 0;
      case 'bio':
        return 1;
      case 'anonProfile':
        return 2;
      case 'addEmail':
        return 3;
      case 'emergencyContact':
        return 4;
      case 'partOfOrg':
        return 5;
      default:
        return -1;
    }
  }

  String getNextPageOnSkip({
    currentpageIndex,
  }) {
    int index = profileController
        .myProfileModel.value.body!.userMoveEmptyScreenEmpty!
        .indexOf(currentpageIndex);
    debugPrint(profileController
        .myProfileModel.value.body!.userMoveEmptyScreenEmpty![index++]
        .toString());
    return getAppRoute(profileController
        .myProfileModel.value.body!.userMoveEmptyScreenEmpty![index++]);
  }

  Future<String> uploadImage(String file, String key, url) async {
    try {
      var response = await Network.uploadFileToServer(
          "${APIConstants.api}/api/fileupload/$url", key, File(file));
      print(response);
      if (response["success"]) {
        return response['imageUrl'];
      } else {
        SolhSnackbar.error('Error', 'opps something went wrong');
        return '';
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'opps something went wrong');
      throw e;
    }
  }

  Future<bool> updateUserProfile(Map<String, dynamic> body) async {
    try {
      isUpdatingField(true);

      var response = await Network.makePutRequestWithToken(
        url: '${APIConstants.api}/api/edit-user-details',
        body: body,
      );

      isUpdatingField(false);
      if (response["success"]) {
        debugPrint("response" + response.toString());
        profileController.myProfileModel.value =
            MyProfileModel.fromJson(response);

        return true;
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        return false;
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateUserAnonProfile(Map<String, dynamic> body) async {
    try {
      isUpdatingField(true);

      var response = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/anonymous',
        body: body,
      );

      isUpdatingField(false);
      if (response["success"]) {
        debugPrint("response" + response.toString());
        profileController.myProfileModel.value =
            MyProfileModel.fromJson(response);

        return true;
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        return false;
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addSosContacts(body) async {
    try {
      var response = await http.put(
          Uri.parse('${APIConstants.api}/api/sosContact'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          });
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      if (decodedResponse["success"]) {
        SolhSnackbar.success('Success', decodedResponse["message"]);
        return true;
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        return false;
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      return false;
    }
  }
}
