import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class HomeController extends GetxController {
  var hat = ''.obs;
  var line = ''.obs;
  Future<void> getTrendingDecoration() async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/custom/events/2022");
      if (map['success']) {
        hat.value = map['data']['hat'];
        line.value = map['data']['line'];
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}
