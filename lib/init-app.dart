import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/bloc/user-bloc.dart';

import 'services/shared_prefrences/shared_prefrences_singleton.dart';
import 'services/user/session-cookie.dart';

Future<Map<String, dynamic>> initApp() async {
  Map<String, dynamic> initialAppData = {};
  bool? localResultForProfile = await Prefs.getBool("isProfileCreated");
  print("isProfileCreated ${localResultForProfile.toString()}");
  if (localResultForProfile != null && localResultForProfile) {
    initialAppData = {"isProfileCreated": true};
  } else {
    initialAppData["isProfileCreated"] =
        await userBlocNetwork.isProfileCreated();
  }

  print("initialAppData*** $localResultForProfile");
  print("Initial app $initialAppData");
  return initialAppData;
}

Future<bool> isNewUser() async {
  var fcmToken = await FirebaseMessaging.instance.getToken();

  String oneSignalId = '';
  await OneSignal.shared.getDeviceState().then((value) {
    oneSignalId = value!.userId ?? '';
  });
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = 'Android';
  } else {
    deviceType = 'IOS';
  }
  print("*" * 30 + "\n" + "One Token: $oneSignalId");

  String phone = await Prefs.getString('phone') ?? '';

  bool? sessionCookie = await SessionCookie.createSessionCookie(
    phone,
    fcmToken,
    oneSignalId,
    deviceType,
  );
  return sessionCookie ?? false;
}
