import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class DurationLang extends StatelessWidget {
  const DurationLang({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (courseDetailController
                .courseDetailEntity.value.courseDetail!.totalDuration !=
            null)
          Row(children: [
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(Icons.access_time,
                  color: SolhColors.primary_green, size: 12),
            ),
            Text(
              "${courseDetailController.courseDetailEntity.value.courseDetail!.totalDuration!.hours} hrs ${courseDetailController.courseDetailEntity.value.courseDetail!.totalDuration!.minutes} mins",
              style: SolhTextStyles.QS_cap_2,
            )
          ]),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 3, bottom: 3, top: 3),
            child: Icon(
              Icons.language,
              size: 12,
              color: SolhColors.primary_green,
            ),
          ),
          Text(
            courseDetailController
                    .courseDetailEntity.value.courseDetail!.language ??
                '',
            style: SolhTextStyles.QS_cap_2,
            maxLines: 1,
          )
        ]),
      ],
    );
  }
}
