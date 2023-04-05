import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/doctors_appointment_model.dart';
import 'package:solh/model/profile/allied_appoinment_list.dart';
import 'package:solh/services/network/network.dart';

import '../../model/user/user_appointments_model.dart';

class AppointmentController extends GetxController {
  var userAppointmentModel = UserAppointmentModel().obs;
  var doctorAppointmentModel = DoctorsAppointmentModel().obs;
  var alliedAppoinmentModel = AlliedAppoinmentModel().obs;
  var isAlliedLoading = false.obs;
  var isAppointmentLoading = false.obs;
  var isRoutingFromBookAppointment = false;

  Future<void> getUserAppointments() async {
    isAppointmentLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/app-user-appointents');

    if (map['success']) {
      userAppointmentModel.value = UserAppointmentModel.fromJson(map);
    }
    isAppointmentLoading.value = false;
  }

  Future<void> getDoctorAppointments() async {
    isAppointmentLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/app-provider-appointents');

    if (map['success']) {
      doctorAppointmentModel.value = DoctorsAppointmentModel.fromJson(map);
    }
    isAppointmentLoading.value = false;
  }

  Future<Map<String, dynamic>> getAlliedBooking() async {
    isAlliedLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/allied/therapies/package/getOrderList");
      print("alliedBooking $map");
      if (map['success']) {
        alliedAppoinmentModel.value = AlliedAppoinmentModel.fromJson(map);
        isAlliedLoading.value = false;
        return map;
      }
    } catch (e) {
      print(e.toString());
      isAlliedLoading.value = false;
      return {"success": false};
    }
    isAlliedLoading.value = false;
    return {"success": false};
  }

  @override
  void onInit() {
    super.onInit();
    getUserAppointments();
  }
}
