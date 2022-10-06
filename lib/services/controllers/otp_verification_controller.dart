import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  var isLoading = false.obs;
  var otpController;

  void updateOtp(String value) {
    print("updateOtp: $value");
    otpController.text = value;
  }
}
