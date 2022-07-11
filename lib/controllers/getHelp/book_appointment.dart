import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class BookAppointmentController extends GetxController {
  var selectedDay = ''.obs;
  var selectedTimeSlot = ''.obs;
  String? doctorName;
  List? days;
  String? query;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController mobileNotextEditingController = TextEditingController();
  TextEditingController catTextEditingController = TextEditingController();
  var isLoading = false.obs;

  Future<String> bookAppointment(Map<String, dynamic> body) async {
    print(APIConstants.api + '/api/appointment');
    isLoading.value = true;
    var response = await Network.makeHttpPostRequestWithToken(
        url: APIConstants.api + '/api/appointment', body: body);
    print('---' + response.toString());
    isLoading.value = false;
    return response;
  }
}
