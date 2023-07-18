import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/offer_carouserl_model.dart';
import 'package:solh/services/network/network.dart';

class OfferCarouselController extends GetxController {
  var isGettingOffers = false.obs;

  var offerCarouselModel = OfferCarouselModel().obs;

  getOffers() async {
    isGettingOffers(true);
    try {
      var response = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/app/organisation/v1/get-home-banners');
      if (response['success']) {
        offerCarouselModel.value = OfferCarouselModel.fromJson(response);
      }
    } catch (e) {}
    isGettingOffers(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getOffers();
    super.onInit();
  }
}
