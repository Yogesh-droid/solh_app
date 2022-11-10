import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/services/network/exceptions.dart';

class Network {
/*   static Future<Map<String, dynamic>> makeHttpGetRequest(String url) async {
  try {
    Uri _uri = Uri.parse(url);
    print(url);

    http.Response apiResponse = await http.get(_uri);
    if (apiResponse.statusCode != 200) {
      print("📶" * 30);

      print("Status Code: " + apiResponse.statusCode.toString());
      throw "server-error";
    } else {
      print(jsonDecode(apiResponse.body));
      return jsonDecode(apiResponse.body)["body"];
    }
  } on SocketException {
    // internetConnectivityBloc.noInternet();
    throw "no-internet";
  } catch (e) {
    print(e);
    throw e;
  }
} */

  static Future<Map<String, dynamic>> makeHttpGetRequestWithToken(
      String url) async {
    try {
      Uri _uri = Uri.parse(url);
      print("requested");
      print("token: ${userBlocNetwork.getSessionCookie}");
      print(url);
      http.Response apiResponse = await http.get(_uri, headers: {
        "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
      });

      switch (apiResponse.statusCode) {
        case 200:
          return jsonDecode(apiResponse.body)['body'];
        case 201:
          return jsonDecode(apiResponse.body)['body'];
        case 404:
          throw Exceptions(error: 'Data Not Found', statusCode: 404);
        default:
          return {};
      }
    } on SocketException {
      throw Exceptions(error: 'No Network', statusCode: 100);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<Map<String, dynamic>> makeHttpPostRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      print(url);
      print(body);
      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.post(_uri, body: body);

      if (apiResponse.statusCode == 201) {
        print(jsonDecode(apiResponse.body));
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        print(jsonDecode(apiResponse.body));
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

  static Future<dynamic> makeHttpPostRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      print(url);
      print(body);
      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.post(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      if (apiResponse.statusCode == 201) {
        print(jsonDecode(apiResponse.body));
        print(jsonDecode(apiResponse.body)["body"]);
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        print(jsonDecode(apiResponse.body));
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
      print(url);
      print(body);
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
      print(url);
      print(body);
      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.put(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body)["body"];
      } else if (apiResponse.statusCode == 200) {
        print(jsonDecode(apiResponse.body));
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
      String url, String key, File file,
      {bool? isVideo}) async {
    Uri uri = Uri.parse(url);

    var request = http.MultipartRequest(
      "POST",
      uri,
    )
      ..headers.addAll(
          {"Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"})
      ..files.add(http.MultipartFile(
          key, file.readAsBytes().asStream(), file.lengthSync(),
          filename: DateTime.now().toString(),
          contentType: isVideo != null
              ? MediaType("video", "mp4")
              : MediaType("image", "png")));

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

  static Future<Map<String, dynamic>> makeGetRequestWithToken(
      String url) async {
    try {
      Uri _uri = Uri.parse(url);
      print("requested");

      print("token: ${userBlocNetwork.getSessionCookie}");
      print(url);
      http.Response apiResponse = await http.get(_uri, headers: {
        "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
      });

      switch (apiResponse.statusCode) {
        case 200:
          return jsonDecode(apiResponse.body)['body'];
        case 201:
          return jsonDecode(apiResponse.body)['body'];
        case 404:
          throw Exceptions(error: 'Data Not Found', statusCode: 404);
        default:
          return {};
      }
    } on SocketException {
      throw Exceptions(error: 'No Network', statusCode: 100);
    } catch (e) {
      print(e);
      throw e;
    }

    /* // headers: {"Authorization": "Bearer ${authBlocNetwork.token}"});

      print("fetched");

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
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
    }*/
  }

  static Future<Map<String, dynamic>> makeGetRequest(String url) async {
    try {
      Uri _uri = Uri.parse(url);
      print("requested");

      print("token: ${userBlocNetwork.getSessionCookie}");
      print(url);
      http.Response apiResponse = await http.get(_uri);

      switch (apiResponse.statusCode) {
        case 200:
          return jsonDecode(apiResponse.body)['body'];
        case 201:
          return jsonDecode(apiResponse.body)['body'];
        case 404:
          throw Exceptions(error: 'Data Not Found', statusCode: 404);
        default:
          return {};
      }
    } on SocketException {
      throw Exceptions(error: 'No Network', statusCode: 100);
    } catch (e) {
      print(e);
      throw e;
    }

    /* // headers: {"Authorization": "Bearer ${authBlocNetwork.token}"});

      print("fetched");

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        Map<String, dynamic> decodedResponse = jsonDecode(apiResponse.body);
        print(decodedResponse);

        return decodedResponse;
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
    } */
  }

  static Future<Map<String, dynamic>> makePostRequestWithToken(
      {required String url,
      required Map<String, dynamic> body,
      bool? isEncoded}) async {
    try {
      Uri _uri = Uri.parse(url);
      print(url);
      print(body);
      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.post(_uri,
          headers: isEncoded != null
              ? {
                  "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}",
                  "Content-Type": "application/json"
                }
              : {"Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"},
          body: isEncoded != null ? jsonEncode(body) : body);

      switch (apiResponse.statusCode) {
        case 200:
          return jsonDecode(apiResponse.body)['body'];
        case 201:
          return jsonDecode(apiResponse.body)['body'];
        case 404:
          throw Exceptions(error: 'Data Not Found', statusCode: 404);
        default:
          return {};
      }
    } on SocketException {
      throw Exceptions(error: 'No Network', statusCode: 100);
    } catch (e) {
      print(e);
      throw e;
    }

    /*  print(apiResponse.statusCode);
      print(jsonEncode(body));

      if (apiResponse.statusCode == 201) {
        print(jsonDecode(apiResponse.body));
        return jsonDecode(apiResponse.body);
      } else if (apiResponse.statusCode == 200) {
        print(jsonDecode(apiResponse.body));
        return jsonDecode(apiResponse.body);
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
    } */
  }

  static Future<Map<String, dynamic>> makePutRequestWithToken({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri _uri = Uri.parse(url);
      print(url);
      print(body);
      print("token: ${userBlocNetwork.getSessionCookie}");
      http.Response apiResponse = await http.put(_uri,
          headers: {
            "Authorization": "Bearer ${userBlocNetwork.getSessionCookie}"
          },
          body: body);

      switch (apiResponse.statusCode) {
        case 200:
          return jsonDecode(apiResponse.body)['body'];
        case 201:
          return jsonDecode(apiResponse.body)['body'];
        case 404:
          throw Exceptions(error: 'Data Not Found', statusCode: 404);
        default:
          return {};
      }
    } on SocketException {
      throw Exceptions(error: 'No Network', statusCode: 100);
    } catch (e) {
      print(e);
      throw e;
    }

    /*  if (apiResponse.statusCode == 201) {
        return jsonDecode(apiResponse.body);
      } else if (apiResponse.statusCode == 200) {
        return jsonDecode(apiResponse.body);
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
    } */
  }
}
