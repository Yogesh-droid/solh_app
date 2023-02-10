import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/services/network/exceptions.dart';
import 'package:solh/services/network/network.dart';

class AlliedController extends GetxController {
  var packagesListModel = PackagesResponseModel().obs;
  var isPackageListFetching = false.obs;
  var selectedPackage = "".obs;
  var selectedPackageIndex = 0;
  var selectedPackagePrice = RxInt(-1);
  var userEmail = "".obs;
  var isBookingLoading = false.obs;

  Future<void> getPackages(String id) async {
    isPackageListFetching.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/package/getList/$id");
      if (map['success']) {
        try {
          packagesListModel.value = PackagesResponseModel.fromJson(map);
          // print(
          //     "this is ${packagesListModel.value.finalResult!.packages![1].packageCategory}");
          print("this is ${packagesListModel.value.finalResult!.name}");

          print("this is ${map["finalResult"]["name"]}");
        } on Exception catch (e) {
          debugPrint(e.toString());
          throw Exceptions(
              error: 'Data is not in proper format', statusCode: 500);
        }
      } else {
        throw Exceptions(error: 'Data not found', statusCode: 404);
      }
    } catch (e) {}
    isPackageListFetching.value = false;
  }

  Future<Map<String, dynamic>> createPackageOrder(Packages package) async {
    Map<String, dynamic> map;

    List<Map<String, dynamic>> videoSession = [];

    package.videoSessions!.forEach((element) {
      videoSession.add({
        "vName": element.vName,
        "duration": element.vDescription,
        "vDescription": element.vDescription
      });
    });

    Map<String, dynamic> body = {
      "packageName": package.name,
      "packageSlug": package.slug,
      "packageDuration": package.duration,
      "packageUnitDuration": package.unitDuration,
      "packageAboutPackage": package.aboutPackage,
      "packageBenefits": package.benefits,
      "packageEquipment": package.equipment,
      "packageVideoSessions": videoSession,
      "packageCurrency": package.currency,
      "packageAmount": package.amount,
      "packageOwner": package.packageOwner,
      "packageType": package.packageType,
      "packageCategory": package.packageCategory,
      "status": "Inprocess",
    };
    try {
      map = {"success": true, "message": "Something went wrong"};
      await Network.makePostRequestWithToken(
          url: "${APIConstants.api}/api/allied/therapies/package/createOrder",
          body: body,
          isEncoded: true);
      //isPackageListFetching.value = false;
      return map;
    } catch (e) {
      //isPackageListFetching.value = false;
      return {"success": false, "message": "Something went wrong"};
    }
  }
}
