import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/features/lms/display/course_detail/data/models/course_details_model.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class InstructorDetails extends StatelessWidget {
  const InstructorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    final Instructor instructor = courseDetailController
        .courseDetailEntity.value.courseDetail!.instructor!;
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: instructor.profilePicture ?? '',
                  height: 130,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              )),
          const SizedBox(width: 20),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instructor.name ?? '',
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: SolhColors.primary_green),
                  ),
                  Text(
                    instructor.mainCategory!.name ?? '',
                    style: SolhTextStyles.QS_body_2,
                  ),
                ],
              )),
        ]),
        const SizedBox(height: 20),
        ReadMoreText(
          instructor.bio ?? '',
          trimLines: 3,
          trimMode: TrimMode.Line,
          lessStyle: const TextStyle(color: SolhColors.primary_green),
          moreStyle: const TextStyle(color: SolhColors.primary_green),
        )
      ],
    );
  }
}
