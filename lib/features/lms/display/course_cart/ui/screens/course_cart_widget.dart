import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/get_course_cart_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/screens/course_items_list.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseCartWidget extends StatelessWidget {
  const CourseCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GetCourseCartController getCourseCartController = Get.find();
    return Obx(() => getCourseCartController.isLoading.value
        ? MyLoader()
        : SingleChildScrollView(
            child: Column(children: [
              // Cart Items
              CourseItemsList()
            ]),
          ));
  }
}
