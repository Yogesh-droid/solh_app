import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigatorController extends GetxController {
  var isDrawerOpen = false.obs;
  PageController pageController = PageController(keepPage: true);

  var activeIndex = 0.obs;
  TabsRouter? tabrouter;
}
