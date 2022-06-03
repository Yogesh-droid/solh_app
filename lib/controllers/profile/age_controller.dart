import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgeController extends GetxController {
  var selectedAge = DateFormat('dd MMMM yyyy').format(DateTime.now()).obs;
  var DOB = ''.obs;
  var isProvider = false.obs;
  void onChanged(String val) {
    selectedAge.value = val;
  }
}
