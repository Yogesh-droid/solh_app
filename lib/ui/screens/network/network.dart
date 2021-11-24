import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solh/constants/api.dart';

class Network {
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

      http.Response apiResponse =
          await http.get(_uri, headers: {"Authorization": "Bearer gjsmn"});

      // headers: {"Authorization": "Bearer ${authBlocNetwork.token}"});

      print("fetched");

      if (apiResponse.statusCode == 200) {
        Map<String, dynamic> decodedResponse = jsonDecode(apiResponse.body);
        print(decodedResponse);
        if (decodedResponse["success"])
          return decodedResponse;
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
