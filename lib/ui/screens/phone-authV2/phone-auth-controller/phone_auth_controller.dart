import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh/services/user/session-cookie.dart';

class PhoneAuthController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  var map = <String, dynamic>{}.obs;

  var countryCode = '+91';
  var isRequestingAuth = false.obs;
  var isCheckingForMpin = false.obs;
  var isCreatingPin = false.obs;
  var isVerifyingPin = false.obs;
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

      if (response['success']) {
        pinVerificationStatus = true;
        isVerifyingPin(false);
      }

      return (response['message'], pinVerificationStatus);
    } catch (e) {
      isVerifyingPin(false);

      rethrow;
    }
  }
}
