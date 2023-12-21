import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';

import '../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../widgets_constants/constants/textstyles.dart';

class InstructorRating extends StatelessWidget {
  const InstructorRating({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (courseDetailController
                .courseDetailEntity.value.courseDetail!.rating !=
            null)
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(Icons.star_half_outlined,
                  color: Color(0xFFFFCC4D), size: 12),
            ),
            Text(
              "${courseDetailController.courseDetailEntity.value.courseDetail!.rating}",
              style: SolhTextStyles.QS_cap_2,
            )
          ]),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 3, bottom: 3, top: 3),
            child: Icon(
              Icons.person_2_outlined,
              size: 12,
              color: SolhColors.red_shade_2,
            ),
          ),
          Text(
            courseDetailController
                    .courseDetailEntity.value.courseDetail!.instructor!.name ??
                '',
            style: SolhTextStyles.QS_cap_2,
            maxLines: 1,
          )
        ]),
      ],
    );
  }
}
