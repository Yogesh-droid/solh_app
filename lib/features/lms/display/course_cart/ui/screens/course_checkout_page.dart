import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/get_course_cart_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/screens/course_cart_widget.dart';
import 'package:solh/features/lms/display/course_cart/ui/widgets/course_checkout_bottom_nav.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseCheckoutPage extends StatelessWidget {
  const CourseCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetCourseCartController getCourseCartController =
        Get.find<GetCourseCartController>();
    return Scaffold(
      appBar: SolhAppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: const Text(
              "Checkout",
              style: SolhTextStyles.QS_body_semi_1,
            ),
          ),
          isLandingScreen: false,
          isVideoCallScreen: true),
      body: const CourseCartWidget(),
    );
  }
}
