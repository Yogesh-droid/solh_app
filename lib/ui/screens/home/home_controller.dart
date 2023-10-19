import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get-help/inhouse_packages_carousel_model.dart';
import 'package:solh/services/network/network.dart';

class HomeController extends GetxController {
  var homePageCarouselModel = InhousePackagesCarouselModel().obs;
  var isBannerLoading = false.obs;
  var isCorouselShown = false.obs;
  var dotList = [].obs;
  var hat = ''.obs;
  var line = ''.obs;
  var noOfNotifications = 0.obs;

  Future<void> getTrendingDecoration() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/custom/events/2022");
      if (map['success']) {
        hat.value = map['data']['hat'];
        line.value = map['data']['line'];
        print('The line is ${line.value}');
      }
    } on Exception {
      // TODO
    }
  }

  Future<Map<String, dynamic>> getHomeCarousel() async {
    isBannerLoading.value = true;
    Map<String, dynamic> map;
    try {
      print("Getting HomeBaner");
      map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/inhouse-package-carousel-list");
      if (map["success"]) {
        isCorouselShown.value = true;
        homePageCarouselModel.value =
            InhousePackagesCarouselModel.fromJson(map);
        for (int i = 0;
            i < homePageCarouselModel.value.packageCarouselList!.length;
            i++) {
          if (dotList.length <
              homePageCarouselModel.value.packageCarouselList!.length) {
            dotList.add(i);
          }
        }
        isBannerLoading.value = false;
        return {"success": true};
      } else {
        isBannerLoading.value = false;
        return {"success": false};
      }
    } catch (e) {
      print(e);
      isBannerLoading.value = false;
      return {"success": false, "message": "Something went wrong"};
    }
  }

  Future<void> getNotificationCount() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/custom/notification-count");
      if (map['success']) {
        noOfNotifications.value = map["notificationCount"];
      }
    } on Exception {
      // TODO
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
