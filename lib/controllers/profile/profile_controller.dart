import 'package:get/get.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/services/network/network.dart';
import '../../constants/api.dart';

class ProfileController extends GetxController {
  var myProfileModel = MyProfileModel().obs;
  var isProfileLoading = false.obs;
  var isEditProfilePicUploading = false.obs;

  Future<void> getMyProfile() async {
    print('gettting My profile');

    try {
      isProfileLoading.value = true;
      //await Future.delayed(Duration(seconds: 30));
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/get-my-profile-details");
      myProfileModel.value = MyProfileModel.fromJson(map);
      print('This is profile   $map');
    } on Exception catch (e) {}
    isProfileLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    //getMyProfile();
  }
}
