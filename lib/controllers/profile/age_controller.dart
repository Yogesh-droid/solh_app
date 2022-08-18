import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solh/bloc/user-bloc.dart';

import '../../model/user/user.dart';

class AgeController extends GetxController {
  var userModel = UserModel().obs;
  var selectedAge = DateFormat('dd MMMM yyyy').format(DateTime.now()).obs;
  var DOB = ''.obs;
  var isProvider = false.obs;
  void onChanged(String val) {
    selectedAge.value = val;
  }

  void getuserData() async {
    userModel.value = userBlocNetwork.myData;
  }
}
