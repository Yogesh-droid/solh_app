import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpVerificationController extends GetxController {
  TextEditingController otpController = TextEditingController();

  void updateOtp(String value) {
    print("updateOtp: $value");
    otpController.text = value;
  }
}
