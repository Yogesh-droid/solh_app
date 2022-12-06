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

  getConsultantDataController(id) async {
    isLoading(true);
    var response = await _consultantDataService.getConsultantData(id);
    isLoading(false);
    print(response.toString());
    consultantModelController.value = response;
  }
}

class ConsultantDataService {
  getConsultantData(id) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/provider-profile?provider=$id')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ConsultantModel.fromJson(map);
    }
  }
}
