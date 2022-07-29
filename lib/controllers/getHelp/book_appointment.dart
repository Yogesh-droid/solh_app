import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class BookAppointmentController extends GetxController {
  var selectedDay = ''.obs;

  /// It's String like Sunday, Monday, Tuesday etc.
  var selectedTimeSlot = ''.obs;

  /// It's String like 9:30-10:30, 10:00-11:00 etc.
  var timeSlotList = [].obs;

  /// It's List of String like 9:30-10:30, 10:00-11:00 etc.
  var selectedDate = DateTime.now().obs;

  /// It's DateTime like 2020-01-01
  String? doctorName;
  List? days;

  /// It's list of dateTime
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
