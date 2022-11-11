import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:solh/bloc/user-bloc.dart';

import 'exceptions.dart';

class NetworkV2 {
  static Future<Map<String, dynamic>> makeHttpGetRequestWithTokenV2(
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
          return jsonDecode(apiResponse.body);
        case 201:
          return jsonDecode(apiResponse.body);
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
}
