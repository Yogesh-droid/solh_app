import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PriceDiscount extends StatelessWidget {
  const PriceDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    return Row(
      children: [
        Text(
          "${courseDetailController.courseDetailEntity.value.courseDetail!.currency} ${courseDetailController.courseDetailEntity.value.courseDetail!.price}",
          style: SolhTextStyles.QS_body_semi_1,
        ),
        const SizedBox(width: 5),
        if (courseDetailController
                .courseDetailEntity.value.courseDetail!.salePrice !=
            null)
          Text(
            "${courseDetailController.courseDetailEntity.value.courseDetail!.currency} ${courseDetailController.courseDetailEntity.value.courseDetail!.salePrice}",
            style: SolhTextStyles.QS_body_2.copyWith(
                decoration: TextDecoration.lineThrough),
          )
      ],
    );
  }
}
