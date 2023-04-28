import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../bloc/user-bloc.dart';
import '../../controllers/profile/profile_controller.dart';
import '../user/session-cookie.dart';

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
      if (kIsWeb) {
        print('Running Auth in flutter web');
        ConfirmationResult confirmationResult =
            await FirebaseAuth.instance.signInWithPhoneNumber('+919191919191');
        UserCredential userCredential =
            await confirmationResult.confirm('123456');

        String idToken = await userCredential.user!.getIdToken();
        print("user idToken: $idToken");
        String? fcmToken = '';
        String oneSignalId = '';
        String deviceType = '';
        // await OneSignal.shared.getDeviceState().then((value) {
        //   print(value!.userId);
        //   oneSignalId = value.userId ?? '';

        //   FirebaseAnalytics.instance.logLogin(
        //       loginMethod: 'PhoneAuth',
        //       callOptions: AnalyticsCallOptions(global: true));
        // });
        // if (Platform.isAndroid) {
        //   deviceType = 'Android';
        // } else {
        //   deviceType = 'IOS';
        // }

        // await initDynamic();

        bool isSessionCookieCreated = await SessionCookie.createSessionCookie(
            idToken, fcmToken, oneSignalId, deviceType,
            utm_medium: '', utm_compaign: '', utm_source: '');
        ProfileController profileController = Get.put(ProfileController());
        await profileController.getMyProfile();
        print(isSessionCookieCreated);
        print("checking is profile created");
        bool isProfileCreated =
            await userBlocNetwork.isProfileCreated() && !isSessionCookieCreated;
        print("profile checking complete");
        print("^" * 30 +
            "Is Profile Created:" +
            isProfileCreated.toString() +
            "^" * 30);
        if (isProfileCreated) {
          print('isProfileCreated $isProfileCreated');
          Navigator.pushNamed(context, AppRoutes.master);
        } else {
          //// .  Firebase Signup event //////
          FirebaseAnalytics.instance.logSignUp(signUpMethod: 'PhoneAuth');
          Navigator.pushNamed(context, AppRoutes.letsCreateYourProfile);

          ////////////////////
        }
      } else {
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
              phoneAuthController.isRequestingAuth.value = false;
              resendToken = forceResendingToken;
              print("Code Sent");

              Navigator.pushNamed(context, AppRoutes.otpVerification,
                  arguments: {
                    "phoneNumber": phoneNo,
                    "verificationId": verificationId,
                  });
              print("verification ID:" + verificationId);
            },
            phoneNumber: phoneNo,
            verificationCompleted:
                (PhoneAuthCredential phoneAuthCredential) async {
              print(phoneAuthCredential.smsCode.toString());
              phoneAuthController.otpCode.text =
                  phoneAuthCredential.smsCode.toString();
            });
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    print("Completed");
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
