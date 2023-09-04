import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/bloc/user-bloc.dart';

import 'services/shared_prefrences/shared_prefrences_singleton.dart';
import 'services/user/session-cookie.dart';

Future<Map<String, dynamic>> initApp() async {
  Map<String, dynamic> initialAppData = {};
  print("cejckndad a");
  bool? localResultForProfile = await Prefs.getBool("isProfileCreated");
  print("isProfileCreated ${localResultForProfile.toString()}");
  if (localResultForProfile != null && localResultForProfile) {
    initialAppData = {"isProfileCreated": true};
  } else {
    initialAppData["isProfileCreated"] =
        await userBlocNetwork.isProfileCreated();
  }

  print("completed");
  print("initialAppData*** $localResultForProfile");
  return initialAppData;
}

Future<bool> isNewUser() async {
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print("*" * 30 + " FCM TOKEN $fcmToken " + "*" * 30);
  User? currentUser = await FirebaseAuth.instance.currentUser;
  String? idToken = currentUser != null
      ? await FirebaseAuth.instance.currentUser!.getIdToken()
      : null;

  String oneSignalId = '';
  await OneSignal.shared.getDeviceState().then((value) {
    print(value!.userId);
    oneSignalId = value.userId ?? '';
  });
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = 'Android';
  } else {
    deviceType = 'IOS';
  }
  print("##########" * 30 + "\n" + "Id Token: $idToken");
  print("*" * 30 + "\n" + "One Token: $oneSignalId");

  bool? sessionCookie = await SessionCookie.createSessionCookie(
    idToken ?? '',
    fcmToken,
    oneSignalId,
    deviceType,
  );
  return sessionCookie ?? false;
}
