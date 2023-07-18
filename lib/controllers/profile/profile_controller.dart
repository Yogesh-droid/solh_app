import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import '../../constants/api.dart';

class ProfileController extends GetxController {
  var myProfileModel = MyProfileModel().obs;
  var isProfileLoading = false.obs;
  var isEditProfilePicUploading = false.obs;

  Future<bool> getMyProfile() async {
    print('gettting My profile');
    try {
      isProfileLoading.value = true;
      //await Future.delayed(Duration(seconds: 30));
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/get-my-profile-details");
      myProfileModel.value = MyProfileModel.fromJson(map);
      if (myProfileModel.value.body!.userOrganisations != null) {
        if (myProfileModel.value.body!.userOrganisations!.isNotEmpty &&
            myProfileModel.value.body!.userOrganisations!.first.status ==
                'Approved') {
          DefaultOrg.setDefaultOrg(myProfileModel
              .value.body!.userOrganisations!.first.organisation!.sId!);
        } else {
          DefaultOrg.setDefaultOrg(null);
        }
      }

      print('This is profile   $map');
      isProfileLoading.value = false;
      return true;
    } on Exception {}
    isProfileLoading.value = false;
    return false;
  }

  Future<void> editProfile(Map<String, dynamic> body) async {
    try {
      isProfileLoading(true);

      var response = await Network.makePutRequestWithToken(
        url: '${APIConstants.api}/api/edit-user-details',
        body: body,
      );

      if (response["success"]) {
        myProfileModel.value = MyProfileModel.fromJson(response);
        isProfileLoading(false);
      } else {
        SolhSnackbar.error('Error', 'Opps, Something went wrong');
        isProfileLoading(false);
      }
    } catch (e) {
      SolhSnackbar.error('Error', 'Opps, Something went wrong');
      debugPrint(e.toString());
      isProfileLoading(false);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    //getMyProfile();
  }
}
