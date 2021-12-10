import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solh/constants/api.dart';

class Network {
  static const String _sessionCookie =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6InRCME0yQSJ9.eyJpc3MiOiJodHRwczovL3Nlc3Npb24uZmlyZWJhc2UuZ29vZ2xlLmNvbS9zb2xoLWZsdXR0ZXIiLCJhdWQiOiJzb2xoLWZsdXR0ZXIiLCJhdXRoX3RpbWUiOjE2Mzg1MTcyNzEsInVzZXJfaWQiOiJlWlpVY2JJQ1hKaGppS2RMekZ1QzBRNXI2RGQyIiwic3ViIjoiZVpaVWNiSUNYSmhqaUtkTHpGdUMwUTVyNkRkMiIsImlhdCI6MTYzODUxNzQzNywiZXhwIjoxNjM5NzI3MDM3LCJwaG9uZV9udW1iZXIiOiIrOTE4NDQ3ODM4MzI3IiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrOTE4NDQ3ODM4MzI3Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGhvbmUifX0.nz-NkdokPLnhHExm5an1pYEpaF7AxDk1Q1Ad3prHXWRr06EST-aX0PbX07p-T1daUVKoMAj-mGhT3nyE5cebl-WPKD3ORYXpaBIhJYxtvjOY184d7MYNtRJiMMT1sAvevZfvYwt6QsIuPvi-eKK89RKK-b9XAd-SAUkKEmcSIz9D-Gs4rR00NaKilOKg2JWNgcLHRAeM87KSMkahL9jMq1pKZRXtiV-ytd-ORPFN4QgKARc4UYjSaELeUgZlQgUFQocTjkvJSN9goHlfoOtKqC40btrLBsrRsC6XgiKJ0z0S8DoWbittLuXp1EYSxnlXNrSlZvEMkDK89AR3BSXbOw";
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

  static Future<Map<String, dynamic>> makeHttpPostRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
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

  static Future<Map<String, dynamic>> makeHttpPostRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response apiResponse = await http.post(_uri,
          headers: {"Authorization": "Bearer ${APIConstants.sessionCookie}"},
          body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body);
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
      ..headers.addAll({"Authorization": "Bearer ${Network._sessionCookie}"})
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
