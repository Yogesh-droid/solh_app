import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class SessionCookie {
  static Future<bool> createSessionCookie(String idToken, String? fcmToken,
      String? onesignalId, String? deviceType) async {
    print("*" * 30 + "\n" + "Id Token: $idToken");
    print("*" * 30 + "\n" + "onesignal Token: $onesignalId");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? coutry = sharedPreferences.getString('userCountry');
    var response = await Network.makeHttpPostRequest(
        url: "${APIConstants.api}/api/create-session-cookie",
        body: {
          "idToken": idToken,
          "deviceId": fcmToken ?? '',
          "onesignal_device_id": onesignalId,
          "deviceType": deviceType,
          "user_country": coutry
        });
    print("*" * 30 + "\n" + "Response: $response");
    userBlocNetwork.updateSessionCookie = response["details"]["sessionCookie"];
    userBlocNetwork.updateUserType =
        response["userType"] != null ? response["userType"] : "";
    response["hiddenPosts"] != null
        ? response["hiddenPosts"].forEach((post) {
            print("*" * 30 + "\n" + "Hidden Post: $post");
            userBlocNetwork.hiddenPosts.add(post);
          })
        : null;
    print("New session cookie: " + userBlocNetwork.getSessionCookie);
    print("*" * 30 + "\n");
    return response["newProfile"] ?? false;
  }
}
