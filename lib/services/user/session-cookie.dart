import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/cache_manager/cache_manager.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting.dart';

class SessionCookie {
  static Future<bool?> createSessionCookie(
      String phone, String? fcmToken, String? onesignalId, String? deviceType,
      {String? utm_compaign, String? utm_source, utm_medium}) async {
    debugPrint("*" * 30 + "\n" + "onesignal Token: $onesignalId");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? coutry = await sharedPreferences.getString('userCountry');
    debugPrint('*' * 30 + 'Country $coutry' + '*' * 30);

    var response;
    Map<String, dynamic>? cachedJson =
        await SolhCacheManager.instance.readJsonCache(key: "sessionCookie");
    print("createSessionCookie running $cachedJson");
    if (cachedJson != null && cachedJson["newProfile"] == false) {
      response = cachedJson;
      userBlocNetwork.updateSessionCookie =
          response["details"]["sessionCookie"];
      print('Cached json used');
    } else {
      response = await Network.makeHttpPostRequest(
          url: "${APIConstants.api}/api/create-session-cookie-v2",
          body: {
            "phone": phone,
            "deviceId": fcmToken ?? '',
            "onesignal_device_id": onesignalId,
            "deviceType": deviceType,
            "user_country": coutry ?? '',
            "utm_compaign": utm_compaign ?? '',
            "utm_source": utm_source ?? '',
            "utm_medium": utm_medium ?? ''
          });
      log({
        "phone": phone,
        "deviceId": fcmToken ?? '',
        "onesignal_device_id": onesignalId,
        "deviceType": deviceType,
        "user_country": coutry ?? '',
        "utm_compaign": utm_compaign ?? '',
        "utm_source": utm_source ?? '',
        "utm_medium": utm_medium ?? ''
      }.toString());
      print("Running${response}");
      if (response["success"] != null) {
        return response['success'];
      }
      if (response["userStatus"] == "Block") {
        print("logged out");
        logOut();
        return false;
      } else {
        await SolhCacheManager.instance.writeJsonCache(
            duration: const Duration(days: 12),
            json: response,
            key: "sessionCookie");
      }

      debugPrint("${"*" * 30}\nResponse: $response");
      userBlocNetwork.updateSessionCookie =
          response["details"]["sessionCookie"];
      userBlocNetwork.updateUserType = response["userType"] ?? "";
      // response["hiddenPosts"] != null
      //     ? response["hiddenPosts"].forEach((post) {
      //         print("*" * 30 + "\n" + "Hidden Post: $post");
      //         userBlocNetwork.hiddenPosts.add(post);
      //       })
      //     : null;
      debugPrint("New session cookie: " + userBlocNetwork.getSessionCookie);
      debugPrint("*" * 30 + "\n");
      // }
      log(response["newProfile"].toString(), name: "newProfile");
      return response["newProfile"] ?? false;
    }
    return null;
  }
}
