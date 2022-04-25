import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/controllers/otp_verification_controller.dart';
import 'package:solh/services/user/session-cookie.dart';

class FirebaseNetwork {
  OtpVerificationController otpVerificationController = Get.put(
    OtpVerificationController(),
  );
  void signInWithPhoneNumber(String phoneNo,
      {required Function(String) onCodeSent}) async {
    var appSignatureID = await SmsAutoFill().getAppSignature;
    try {
      print("calling verify phoneNo");
      await FirebaseAuth.instance.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          verificationFailed: (FirebaseAuthException error) {
            print("@@@@@@@@@@@@@@@@@@@@/n");
            print(error.message);
            ScaffoldMessenger.of(globalNavigatorKey.currentState!.context)
                .showSnackBar(SnackBar(content: Text(error.code.toString())));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            //otpVerificationController.updateOtp('123456');
            print("Code Sent");
            onCodeSent.call(verificationId);
            AutoRouter.of(globalNavigatorKey.currentState!.context).push(
                OTPScreenRouter(
                    phoneNo: phoneNo, verificationId: verificationId));
            print("verification ID:" + verificationId);
          },
          phoneNumber: phoneNo,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            print("verification completed");
            print(phoneAuthCredential.smsCode.toString());
            otpVerificationController
                .updateOtp(phoneAuthCredential.smsCode ?? '');
            print(phoneAuthCredential.verificationId);
            // print(phoneAuthCredential.providerId);
            UserCredential userCredential =
                await signInWithPhoneCredential(phoneAuthCredential);
            print("user token" + userCredential.credential!.token.toString());
            print("verified");

            print("user idToken: ${userCredential.credential!.token}");
            bool isSessionCookieCreated =
                await SessionCookie.createSessionCookie(
                    userCredential.credential!.token.toString());
            print(isSessionCookieCreated);
            print("checking is profile created");
            bool isProfileCreated = await userBlocNetwork.isProfileCreated();
            print("profile checking complete");

            print("^" * 30 +
                "Is Profile Created:" +
                isProfileCreated.toString() +
                "^" * 30);
            isProfileCreated
                ? AutoRouter.of(globalNavigatorKey.currentState!.context)
                    .pushAndPopUntil(MasterScreenRouter(),
                        predicate: (value) => false)
                : AutoRouter.of(globalNavigatorKey.currentState!.context)
                    .pushAndPopUntil(CreateProfileScreenRouter(),
                        predicate: (value) => false);
          });
    } on FirebaseAuthException catch (e) {
      print("bdkasbfk fk sbg kbjkrgb kajdfngljnealrgnalsf ;lawrnh");
      print('Failed with error code: ${e.code}');
      print(e.message);
    } catch (e) {
      print("bdkasbfk fk sbg kbjkrgb kajdfngljnealrgnalsf ;lawrnh");

      print(e);
    }
    print("Completed");
    // print(_user.verificationId);
    // _user.confirm(verificationCode);
  }

  static Future<UserCredential> signInWithPhoneCredential(
      AuthCredential credential) async {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
