import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class BookAppointmentController extends GetxController {
  var selectedDay = ''.obs;
  var selectedTimeSlot = ''.obs;
  String? doctorName;
  List? days;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController mobileNotextEditingController = TextEditingController();
  TextEditingController catTextEditingController = TextEditingController();

  Future bookAppointment(Map<String, dynamic> body) async {
    print(APIConstants.api + '/api/appointment');
    var response = await Network.makeHttpPostRequestWithToken(
        url: APIConstants.api + '/api/appointment', body: body);
    print('---' + response.toString());
    return response;
  }
}
