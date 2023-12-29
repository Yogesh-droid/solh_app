import 'dart:io';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';

class MakeOrderController extends GetxController {
  var isCreatingOrder = false.obs;
  var success = ''.obs;
  var err = ''.obs;

  Future<void> makeOrderRequest(Map<String, dynamic> postBody) async {
    isCreatingOrder.value = true;
    success.value = '';
    err.value = '';
    try {
      Map<String, dynamic> response = await Network.makePostRequestWithToken(
          isEncoded: true,
          url: '${APIConstants.api}/api/product/order-product',
          body: postBody);
      isCreatingOrder.value = false;

      if (response["success"]) {
        success.value = response['message'] ?? "Order created successfully";
      } else {
        err.value = response['message'] ?? 'Something went wrong';
      }
    } on SocketException {
      Utility.showToast("Something went wrong with your network");
    } on Exception catch (e) {
      Utility.showToast(e.toString());
    }
  }
}
