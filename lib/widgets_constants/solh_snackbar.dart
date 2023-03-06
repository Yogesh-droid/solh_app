import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhSnackbar {
  static SnackbarController success(String title, String message,
      {Icon? icon = null}) {
    return Get.snackbar(title, message,
        backgroundColor: SolhColors.greenShade1,
        duration: Duration(milliseconds: 900),
        snackPosition: SnackPosition.BOTTOM);
  }

  static SnackbarController error(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        backgroundColor: SolhColors.primaryRed,
        duration: Duration(milliseconds: 900),
        snackPosition: SnackPosition.BOTTOM);
  }
}
