import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solh/constants/api.dart';
import 'package:solh/services/shared-prefrences/session-cookie.dart';

class Network {
  static const String _sessionCookie =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6InRCME0yQSJ9.eyJpc3MiOiJodHRwczovL3Nlc3Npb24uZmlyZWJhc2UuZ29vZ2xlLmNvbS9zb2xoLWZsdXR0ZXIiLCJhdWQiOiJzb2xoLWZsdXR0ZXIiLCJhdXRoX3RpbWUiOjE2MzczMDYzNDcsInVzZXJfaWQiOiJlWlpVY2JJQ1hKaGppS2RMekZ1QzBRNXI2RGQyIiwic3ViIjoiZVpaVWNiSUNYSmhqaUtkTHpGdUMwUTVyNkRkMiIsImlhdCI6MTYzNzMwNjc1NiwiZXhwIjoxNjM4NTE2MzU2LCJwaG9uZV9udW1iZXIiOiIrOTE4NDQ3ODM4MzI3IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrOTE4NDQ3ODM4MzI3Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.XAZJEKsJon2_30B2VnKAwnBqk9CXvfDVLjQHc2-JHBGWu-A8dSccuwn8bn7XZfjfIpvtJZfpaQ2h_lBFaASmhS0VmWH6utj7PSC2mati_xiGsjvwfVyM2WtswUks277I030vDDcX-BEbWjgrKCgU0cFRhs7aJhHa530T1z3gW3bGKLMPALFc32xbpMsQq8BOPpXEJoCrOx_oij_vaecAonPd7thSBaxYuQmqedx25WKUY-5K37KbiBOsaKZAvhPN4r50DcUsDpXF6PK_o9hjHytES0leFpwkoU0kmiOenE9eoYsVs9bw_RthuPjgGLwJvivebMU60Bl8BYH5Ii67fg";

  static Future<Map<String, dynamic>> makeHttpGetRequest(String url) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.get(_uri);
      if (apiResponse.statusCode != 200) {
        print("📶" * 30);
        print("Status Code: " + apiResponse.statusCode.toString());
        throw "server-error";
      } else {
        return jsonDecode(apiResponse.body);
      }
    } on SocketException {
      // internetConnectivityBloc.noInternet();
      throw "no-internet";
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<Map<String, dynamic>> makeHttpGetRequestWithToken(
      String url) async {
    try {
      Uri _uri = Uri.parse(url);
      print("requested");

      // print("token: ${authBlocNetwork.token}");

      http.Response apiResponse = await http
          .get(_uri, headers: {"Authorization": "Bearer $_sessionCookie"});

      // headers: {"Authorization": "Bearer ${authBlocNetwork.token}"});

      print("fetched");

      if (apiResponse.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(apiResponse.body);
        print(decodedResponse);
        if (decodedResponse["success"])
          return decodedResponse["body"];
        else
          throw "invalid token";
      } else {
        print(apiResponse.body);
        print("Status Code: " + apiResponse.statusCode.toString());
        throw "server-error";
      }
    } on SocketException {
      // internetConnectivityBloc.noInternet();
      throw "no-internet";
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // static Future checkInternetConnectivity() async {
  //   Uri _uri = Uri.parse("https://google.com");
  //   await http
  //       .get(_uri)
  //       .then((value) => internetConnectivityBloc.okInternet())
  //       .onError((error, stackTrace) {
  //     if (error == SocketException) internetConnectivityBloc.noInternet();
  //   });
  // }

  static Future<Map<String, dynamic>> makeHttpPostRequest(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.post(_uri, body: body);

      if (apiResponse.statusCode != 200) {
        print("Status Code: " + apiResponse.statusCode.toString());
        throw "server-error";
      } else {
        return jsonDecode(apiResponse.body);
      }
    } on SocketException {
      // internetConnectivityBloc.noInternet();
      throw "no-internet";
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<Map<String, dynamic>> makeHttpPostRequestWithToken(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.post(_uri,
          headers: {"Authorization": "Bearer ${APIConstants.sessionCookie}"},
          body: body);

      if (apiResponse.statusCode != 200) {
        print("Status Code: " + apiResponse.statusCode.toString());
        throw "server-error";
      } else {
        return jsonDecode(apiResponse.body);
      }
    } on SocketException {
      // internetConnectivityBloc.noInternet();
      throw "no-internet";
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
