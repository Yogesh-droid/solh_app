import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/appointment_video_call_icon_model.dart';
import 'package:solh/services/network/network.dart';

class AppointmentVideoCallIconController extends GetxController {
  var appointmentVideoCallIconModel = AppointmentVideoCallIconModel().obs;
  Future<void> getVideoCallIcon(String providerId) async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/agora/join-exist-call?providerId=$providerId');
      appointmentVideoCallIconModel.value =
          AppointmentVideoCallIconModel.fromJson(map);
      print('Data for icon $map');
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
