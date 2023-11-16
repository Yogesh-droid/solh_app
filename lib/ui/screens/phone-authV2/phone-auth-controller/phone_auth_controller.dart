import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class PhoneAuthController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  var map = <String, dynamic>{}.obs;

  var countryCode = '+91';
  var isRequestingAuth = false.obs;
  TextEditingController otpCode = TextEditingController();

  Future<void> login(String countryCode, String phoneNo) async {
    isRequestingAuth.value = true;
    map.value = await Network.makePostRequest(
        url: "${APIConstants.api}/api/user/send-auth-code",
        body: {
          "countryCode": "$countryCode",
          "phone": "${countryCode}${phoneNo}"
        });
    isRequestingAuth.value = false;
  }

  Future<Map<String, dynamic>> verifyCode(
      String dialCode, String phoneNo, String code) async {
    map.value = await Network.makePostRequest(
        url: "${APIConstants.api}/api/user/verify-auth-code",
        body: {"dialCode": "$dialCode", "phone": "$phoneNo", "code": "$code"});

    return map;
  }
}
