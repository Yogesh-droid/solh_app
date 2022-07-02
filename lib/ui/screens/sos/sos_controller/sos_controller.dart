import 'dart:convert';

import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

import 'package:http/http.dart' as http;

class SosController extends GetxController {
  var isAdded = false;

  var selectedPersons = 0.obs;

  var selectedTags = [].obs;
  var selectedItems = {}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getSosContacts();

    super.onInit();
  }

  Future addSosContacts(body) async {
    return await http.put(Uri.parse('${APIConstants.api}/api/sosContact'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
        }).then((value) {
      print(value.body);
      return value.body;
    });
  }
}

Future getSosContacts() async {
  return await http
      .get(Uri.parse('${APIConstants.api}/api/sosContact'), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
  }).then((value) {
    print(value.body);
    return value.body;
  });
}
