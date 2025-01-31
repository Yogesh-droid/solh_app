import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/get-help/inhouse_package_model.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/services/network/exceptions.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class AlliedController extends GetxController {
  var packagesListModel = PackagesResponseModel().obs;
  var inhousePackageModel = InhousePackageModel().obs;
  var inhousePackageFetching = false.obs;
  var isPackageListFetching = false.obs;
  var isInHouseBooking = false.obs;
  var isAlliedBooking = false.obs;
  var selectedPackage = "".obs;
  var selectedPackageIndex = 0;
  var selectedPackagePrice = RxInt(-1);
  var selectedPackageDiscountedPrice = RxInt(-1);
  var selectedCurrency = ''.obs;
  var userEmail = "".obs;
  var isBookingLoading = false.obs;
  var isShareingLink = false.obs;
  var isShareingProviderLink = false.obs;

  Future<void> getPackages(String id) async {
    isPackageListFetching.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/package/getList/$id");
      if (map['success']) {
        try {
          packagesListModel.value = PackagesResponseModel.fromJson(map);
          if (packagesListModel.value.finalResult != null) {
            if (packagesListModel.value.finalResult!.packages!.isNotEmpty) {
              selectedPackage.value =
                  packagesListModel.value.finalResult!.packages![0].sId ?? '';
              selectedPackagePrice.value =
                  packagesListModel.value.finalResult!.packages![0].amount ?? 0;
              selectedPackageDiscountedPrice.value = packagesListModel
                      .value.finalResult!.packages![0].afterDiscountPrice ??
                  0;
              selectedCurrency.value =
                  packagesListModel.value.finalResult!.packages![0].currency ??
                      '';
            }
          }
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
    List<Map<String, dynamic>> videoSession = [];

    package.videoSessions!.forEach((element) {
      videoSession.add({
        "vName": element.vName,
        "duration": element.vDescription,
        "vDescription": element.vDescription
      });
    });
    isAlliedBooking(true);
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
      "packageAmount": package.afterDiscountPrice! > 0
          ? package.afterDiscountPrice
          : package.amount,
      "packageAmountOriginal": package.amount,
      "organisationId": DefaultOrg.defaultOrg ?? '',
      "packageOwner": package.packageOwner,
      "packageType": package.packageType,
      "packageCurrencyCode": package.feeCode,
      "packageCategory": package.packageCategory,
      "status": "Inprocess",
      "email": userEmail.value,
    };
    try {
      var map = await Network.makePostRequestWithToken(
          url: "${APIConstants.api}/api/allied/therapies/package/createOrder",
          body: body,
          isEncoded: true);

      return map;
    } catch (e) {
      return {"success": false, "message": "Something went wrong"};
    }
  }

  Future<Map<String, dynamic>> createInhousePackageOrder(
      PackageList package) async {
    isInHouseBooking(true);
    Map<String, dynamic> body = {
      "packageName": package.name,
      "packageSlug": package.slug,
      "packageDuration": package.duration,
      "packageUnitDuration": package.unitDuration,
      "packageAboutPackage": package.aboutPackage,
      "packageBenefits": package.benefits,
      "packageEquipment": package.equipment,
      "packageCurrency": package.currency,
      "packageAmount": package.amount,
      "packageOwner": package.packageOwner,
      "packageType": package.packageType!.sId,
      "createdBy":
          Get.find<ProfileController>().myProfileModel.value.body!.user!.sId,
      "status": "Inprocess",
      "mainCategory": package.mainCategory!.sId,
      "carouselName": package.packageCarouselId!.name,
      "email": userEmail.value,
      "packageCurrencyCode": package.feeCode ?? "INR"
    };
    try {
      var map = await Network.makePostRequestWithToken(
          url: "${APIConstants.api}/api/allied/therapies/place-inhouse-order",
          body: body,
          isEncoded: true);
      //isPackageListFetching.value = false;

      print("map** $map");
      return map;
    } catch (e) {
      //isPackageListFetching.value = false;
      return {"success": false, "message": "Something went wrong"};
    }
  }

  Future<void> getInhousePackage(String packageId) async {
    try {
      inhousePackageFetching(true);
      var map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/inhouse-package-carousel-details/$packageId");

      if (map["success"]) {
        inhousePackageModel.value = InhousePackageModel.fromJson(map);
        inhousePackageFetching(false);
      }
    } catch (e) {
      inhousePackageFetching(false);
      SolhSnackbar.error('Opps', 'Something went wrong');
    }
  }
}
