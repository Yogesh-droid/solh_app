import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhSnackbar {
  static SnackbarController error(String title, String message) {
    return Get.snackbar(title, message,
        backgroundColor: SolhColors.primaryRed,
        snackPosition: SnackPosition.BOTTOM);
  }
}
