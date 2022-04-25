import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgeController extends GetxController {
  var selectedAge = DateFormat('dd MMMM yyyy').format(DateTime.now()).obs;

  void onChanged(String val) {
    selectedAge.value = val;
  }
}
