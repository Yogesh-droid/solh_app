import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpVerificationController extends GetxController {
  var isLoading = false.obs;
  TextEditingController otpController = TextEditingController();

  void updateOtp(String value) {
    print("updateOtp: $value");
    otpController.text = value;
  }
}
