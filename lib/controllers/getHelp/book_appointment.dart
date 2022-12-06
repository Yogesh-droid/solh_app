import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class BookAppointmentController extends GetxController {
  var selectedDayForTimeSlot = DateTime.now().day.obs;

  var selectedDay = DateFormat('EEEE').format(DateTime.now()).obs;

  /// It's String like Sunday, Monday, Tuesday etc.
  var selectedTimeSlot = ''.obs;
  var selectedTimeSlotN = ''.obs;

  /// It's String like 9:30-10:30, 10:00-11:00 etc.
  var timeSlotList = [].obs;
  var bookedTimeSlots = [].obs;

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
  var loadingTimeSlots = false.obs;
  dynamic isTimeSlotAdded = ''.obs;

  var showBookingDetail = false.obs;

  Future<String> bookAppointment(Map<String, dynamic> body) async {
    print(APIConstants.api + '/api/appointment');
    isLoading.value = true;
    var response = await Network.makeHttpPostRequestWithToken(
        url: APIConstants.api + '/api/appointment', body: body);
    print('---' + response.toString());
    isLoading.value = false;
    return response;
  }

  Future<void> isSlotAdded({required String providerId}) async {
    isLoading.value = true;

    var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var response = await Network.makeGetRequest(
      APIConstants.api +
          '/api/provider-schedule?provider=$providerId&date=$date',
    );
    print('---' + response.toString());
    isLoading.value = false;
    isTimeSlotAdded.value = response['slotsAdded'].toString();
  }

  Future<void> getTimeSlot({String? providerId, String? date}) async {
    String currentTimeSlot = DateFormat('HH:00').format(DateTime.now()) +
        '-' +
        DateFormat('HH:00').format(DateTime.now().add(Duration(hours: 1)));
    print(currentTimeSlot);
    loadingTimeSlots.value = true;
    var response = await Network.makeGetRequest(APIConstants.api +
        '/api/provider-schedule?provider=$providerId&date=$date');
    timeSlotList.value = response['slot'];
    response['bookedSlots'] != null
        ? bookedTimeSlots.value = response['bookedSlots']
        : bookedTimeSlots.value = [];
    if (selectedDate.value.day == DateTime.now().day) {
      print('selectedDate.value == DateTime.now()');
      timeSlotList.value = timeSlotList.value
          .where((element) => element.toString().compareTo(currentTimeSlot) > 0)
          .toList();
    }
    print(timeSlotList.length);
    timeSlotList.refresh();
    loadingTimeSlots.value = false;
  }
}
