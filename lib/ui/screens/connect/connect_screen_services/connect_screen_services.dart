import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/services/network/exceptions.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/network/networkV2.dart';
import 'package:solh/ui/screens/connect/connect_sceen_model/connect_screen_model.dart';

class ConnectScreenServices {
  ConnectionController connectionController = Get.find();
  Future<dynamic> getProfileDetails(String sId) async {
    try {
      var response = await NetworkV2.makeHttpGetRequestWithTokenV2(
          '${APIConstants.api}/api/user/v1/user-profile/$sId');
      print('response ' + response.toString());

      return ConnectScreenModel.fromJson(response);
    } on Exceptions catch (e) {
      throw e.getStatus();
    }
  }
}
