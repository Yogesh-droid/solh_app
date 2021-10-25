import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.gr.dart';

class FirebaseNetwork {
  static signInWithPhoneNumber(String phoneNo,
      {required Function(String) onCodeSent}) async {
    try {
      print("calling verify phoneNo");

      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationFailed: (FirebaseAuthException error) {
            print("@@@@@@@@@@@@@@@@@@@@/n");
            print(error.message);
            ScaffoldMessenger.of(globalNavigatorKey.currentState!.context)
                .showSnackBar(SnackBar(content: Text(error.code.toString())));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            print("Code Sent");
            onCodeSent.call(verificationId);
            AutoRouter.of(globalNavigatorKey.currentState!.context).push(
                OTPScreenRouter(
                    phoneNo: phoneNo, verificationId: verificationId));
            // print("verification ID:" + verificationId);
          },
          phoneNumber: phoneNo,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            // print(phoneAuthCredential.verificationId);
            // print(phoneAuthCredential.providerId);
            await signInWithPhoneCredential(phoneAuthCredential);
            print("verified");
            AutoRouter.of(globalNavigatorKey.currentState!.context)
                .push(MasterScreenRouter());
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
