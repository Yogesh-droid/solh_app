import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class SessionCookie {
  static Future<bool> createSessionCookie(String idToken) async {
    var response = await Network.makeHttpPostRequest(
        url: "${APIConstants.api}/api/create-session-cookie",
        body: {"idToken": idToken});
    userBlocNetwork.updateSessionCookie = response["details"]["sessionCookie"];
    print("New session cookie: " + userBlocNetwork.getSessionCookie);
    return true;
  }
}
