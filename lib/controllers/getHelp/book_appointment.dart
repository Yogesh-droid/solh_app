import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class BookAppointmentController extends GetxController {
  var selectedDay = ''.obs;
  var selectedTimeSlot = ''.obs;
  var timeSlotList = [].obs;
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

  Future<void> getTimeSlot({String? providerId, String? date}) async {
    var response = await Network.makeGetRequest(APIConstants.api +
        '/api/provider-schedule?provider=6294874e1044fc665b57af3f&date=$date');
    timeSlotList.value = response['slot'];
    timeSlotList.refresh();
  }
}
