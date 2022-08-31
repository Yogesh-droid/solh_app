import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:solh/bloc/user-bloc.dart';

import 'services/user/session-cookie.dart';

Future<Map<String, dynamic>> initApp() async {
  Map<String, dynamic> initialAppData = {};
  print("cejckndad a");
  initialAppData["isProfileCreated"] = await userBlocNetwork.isProfileCreated();
  print("completed");
  return initialAppData;
}

Future<bool> isNewUser() async {
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print("*" * 30 + " FCM TOKEN $fcmToken " + "*" * 30);
  String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
  String oneSignalId = '';
  await OneSignal.shared.getDeviceState().then((value) {
    print(value!.userId);
    oneSignalId = value.userId ?? '';
  });
  print("*" * 30 + "\n" + "Id Token: $idToken");
  print("*" * 30 + "\n" + "One Token: $oneSignalId");

  return await SessionCookie.createSessionCookie(
      idToken, fcmToken, oneSignalId);
}
