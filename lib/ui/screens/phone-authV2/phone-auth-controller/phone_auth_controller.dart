import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';

class PhoneAuthController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  var map = <String, dynamic>{}.obs;

  var countryCode = '+91';
  var country = 'IN';
  var isOtpVerified = false.obs;
  var isVerifyingOtp = false.obs;
  var isRequestingAuth = false.obs;
  var isCheckingForMpin = false.obs;
  var isCreatingPin = false.obs;
  var isVerifyingPin = false.obs;
  TextEditingController otpCode = TextEditingController();

  Future<(bool, String)> login(String countryCode, String phoneNo) async {
    isRequestingAuth.value = true;
    try {
      bool loginStatus = false;
      map.value = await Network.makePostRequest(
          url: "${APIConstants.api}/api/user/send-auth-code",
          body: {"countryCode": countryCode, "phone": "$countryCode$phoneNo"});

      if (map.value['success']) {
        loginStatus = map.value['success'];
      }
      isRequestingAuth.value = false;
      return (loginStatus, map.value['message'].toString());
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyCode(
      String dialCode, String phoneNo, String code) async {
    isVerifyingOtp(true);
    map.value = await Network.makePostRequest(
        url: "${APIConstants.api}/api/user/verify-auth-code",
        body: {"dialCode": dialCode, "phone": phoneNo, "code": code});
    log(map.value.toString());
    isVerifyingOtp(false);
    return map;
  }

  Future<bool> isMpinSet(String phoneNo) async {
    isCheckingForMpin(true);
    try {
      bool mPinStatus = false;
      var response = await Network.makeGetRequest(
          '${APIConstants.api}/api/is-mpin-set/$phoneNo');

      if (response["success"]) {
        mPinStatus = response['hasMpin'];
      }
      isCheckingForMpin(false);
      return mPinStatus;
    } catch (e) {
      isCheckingForMpin(false);
      rethrow;
    }
  }

  Future<bool> createMpin(String phoneNo, String pin) async {
    isCreatingPin(true);
    try {
      bool createMpinStatus = false;

      var response = await Network.makePostRequest(
          url: '${APIConstants.api}/api/set-mpin',
          body: {'mobile': phoneNo, 'mpin': pin});
      if (response["success"]) {
        createMpinStatus = true;
      }
      isCreatingPin(false);
      return createMpinStatus;
    } catch (e) {
      isCreatingPin(false);
      rethrow;
    }
  }

  Future verifyPin(String phoneNo, String pin) async {
    isVerifyingPin(true);
    try {
      bool pinVerificationStatus = false;

      var response = await Network.makePostRequest(
          url: '${APIConstants.api}/api/verify-mpin',
          body: {'mobile': phoneNo, 'mpin': pin});
      log(response.toString());
      if (response['success']) {
        pinVerificationStatus = true;
      }
      isVerifyingPin(false);
      return (response['message'], pinVerificationStatus);
    } catch (e) {
      isVerifyingPin(false);

      rethrow;
    }
  }

  Future<void> signInWithPhoneNumber(context, String country) async {
    await login(countryCode, phoneNumber.text);

    if (map['success']) {
      log(map['message']);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userCountry', country);
      Get.find<SearchMarketController>().country = country;
      Navigator.pushNamed(context, AppRoutes.otpVerification, arguments: {
        "phoneNumber": phoneNumber.text,
        "dialCode": countryCode
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(map['message'])));
    }
  }
}
