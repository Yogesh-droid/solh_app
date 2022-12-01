import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneAuthController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();

  var countryCode = '+91';
  var isRequestingAuth = false.obs;
  List<TextEditingController> otpCode = <TextEditingController>[];

  void assignOtp(String otp) {}
}
