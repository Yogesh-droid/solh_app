import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user/consultant_model.dart';
import 'package:solh/services/network/network.dart';

class ConsultantController extends GetxController {
  var isLoading = false.obs;
  var isTitleVisible = false.obs;
  var isAnonymousBookingEnabled = false.obs;

  var consultantModelController = ConsultantModel().obs;
  ConsultantDataService _consultantDataService = ConsultantDataService();
  var isSharingLink = false.obs;

  getConsultantDataController(id, String currency,
      {String? countrycode}) async {
    try {
      log(currency);
      isLoading(true);
      var response =
          await _consultantDataService.getConsultantData(id, currency);
      isLoading(false);
      print(response.toString());
      consultantModelController.value = response;
    } on Exception catch (e) {
      throw (e);
    }
  }
}

class ConsultantDataService {
  getConsultantData(id, currency) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api +
                '/api/provider-profile?provider=$id&currency=$currency')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ConsultantModel.fromJson(map);
    }
  }
}
