import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/get_course_cart_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/widgets/course_cart_items_tile.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseItemsList extends StatelessWidget {
  const CourseItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final GetCourseCartController getCourseCartController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item(s)",
                style:
                    SolhTextStyles.QS_body_1_med.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ...getCourseCartController.cartList
                  .map((element) => CourseCartItemsTile(
                        onTap: () {},
                        onDeleteTap: () {},
                        currency: element.currency,
                        image: element.thumbnail,
                        price: element.price,
                        title: element.title,
                        discountedPrice: element.salePrice,
                      ))
            ],
          ),
        ));
  }
}
