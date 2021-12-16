import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solh/bloc/user-bloc.dart';

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
        return jsonDecode(apiResponse.body)["body"];
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

      http.Response apiResponse = await http.get(_uri, headers: {
        "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
      });

      // headers: {"Authorization": "Bearer ${authBlocNetwork.token}"});

      print("fetched");

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
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

  static Future<Map<String, dynamic>> makeHttpPostRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.post(_uri, body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        return jsonDecode(apiResponse.body)["body"];
      } else {
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

  static Future<Map<String, dynamic>> makeHttpPostRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.post(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        return jsonDecode(apiResponse.body)["body"];
      } else {
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

  static Future<Map<String, dynamic>> makeHttpDeleteRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.delete(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        return jsonDecode(apiResponse.body)["body"];
      } else {
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

  static Future<Map<String, dynamic>> makeHttpPutRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.put(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        return jsonDecode(apiResponse.body)["body"];
      } else {
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

  static Future<Map<String, dynamic>> uploadFileToServer(
      String url, String key, File file) async {
    Uri uri = Uri.parse(url);

    var request = http.MultipartRequest(
      "POST",
      uri,
    )
      ..headers.addAll(
          {"Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"})
      ..files.add(http.MultipartFile(
          key, file.readAsBytes().asStream(), file.lengthSync(),
          filename: DateTime.now().toString()));

    var response = await request.send();
    var apiResponse = jsonDecode(await response.stream.bytesToString());
    print(apiResponse);
    if (response.statusCode == 200)
      return {
        "success": true,
        "imageUrl": apiResponse["data"]["location"],
        "mimetype": apiResponse["data"]["mimetype"]
      };
    return {
      "success": false,
    };
  }
}
