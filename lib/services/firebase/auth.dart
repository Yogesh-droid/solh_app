import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/controllers/otp_verification_controller.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class FirebaseNetwork {
  // OtpVerificationController otpVerificationController = Get.find();
  PhoneAuthController phoneAuthController = Get.find();
  int? resendToken;

  void signInWithPhoneNumber(
    BuildContext context,
    String phoneNo,
  ) async {
    try {
      print("calling verify phoneNo" + phoneNo);
      await FirebaseAuth.instance.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          verificationFailed: (FirebaseAuthException error) {
            print("@@@@@@@@@@@@@@@@@@@@/n");
            print(error.message);
            phoneAuthController.isRequestingAuth.value = false;
            Get.snackbar('Error', error.message.toString(),
                backgroundColor: SolhColors.primaryRed,
                snackPosition: SnackPosition.BOTTOM);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            //otpVerificationController.updateOtp('123456');
            phoneAuthController.isRequestingAuth.value = false;
            resendToken = forceResendingToken;
            print("Code Sent");

            Navigator.pushNamed(context, AppRoutes.otpVerification, arguments: {
              "phoneNumber": phoneNo,
              "verificationId": verificationId
            });
            // AutoRouter.of(globalNavigatorKey.currentState!.context).push(
            //     OTPScreenRouter(
            //         phoneNo: phoneNo, verificationId: verificationId));
            print("verification ID:" + verificationId);
          },
          phoneNumber: phoneNo,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            print(phoneAuthCredential.smsCode.toString());
            phoneAuthController.otpCode.text =
                phoneAuthCredential.smsCode.toString();

            // otpVerificationController
            //     .updateOtp(phoneAuthCredential.smsCode.toString());

            /* print(phoneAuthCredential.smsCode.toString());
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
                      predicate: (value) => false); */
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

  void resendOtp(
    String phoneNo,
  ) async {
    print("resending otp ${resendToken}");
    try {
      print("calling verify phoneNo");
      await FirebaseAuth.instance.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          verificationFailed: (FirebaseAuthException error) {
            print("@@@@@@@@@@@@@@@@@@@@/n");
            print(error.message);
            // otpVerificationController.isLoading.value = false;
            ScaffoldMessenger.of(globalNavigatorKey.currentState!.context)
                .showSnackBar(SnackBar(content: Text(error.code.toString())));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            //otpVerificationController.updateOtp('123456');
            print("Code ReSent");
            print("verification ID:" + verificationId);
          },
          phoneNumber: phoneNo,
          forceResendingToken: resendToken,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            // otpVerificationController
            //     .updateOtp(phoneAuthCredential.smsCode.toString());
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
  }

  static Future<UserCredential> signInWithPhoneCredential(
      AuthCredential credential) async {
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
