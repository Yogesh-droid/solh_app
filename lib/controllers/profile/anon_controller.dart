import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class AnonController extends GetxController {
  var isNameTaken = false.obs;

  Future<void> checkIfUserNameTaken(String name) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/is-username-taken',
        body: {'first_name': name});
    isNameTaken.value = map['body']['isCreated'];
  }
}
