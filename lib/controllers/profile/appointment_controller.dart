import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

import '../../model/user/user_appointments_model.dart';

class AppointmentController extends GetxController {
  var userAppointmentModel = UserAppointmentModel().obs;
  var isAppointmentLoading = false.obs;

  Future<void> getUserAppointments() async {
    isAppointmentLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/app-user-appointents');

    if (map['success']) {
      userAppointmentModel.value = UserAppointmentModel.fromJson(map);
    }
    isAppointmentLoading.value = false;
  }
}
