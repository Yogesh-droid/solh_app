import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class SessionCookie {
  static Future<String?> createSessionCookie(String idToken) async {
    var response = await Network.makeHttpPostRequest(
        url: "${APIConstants.api}/api/create-session-cookie",
        body: {"idToken": idToken});
    return response.toString();
  }
}
