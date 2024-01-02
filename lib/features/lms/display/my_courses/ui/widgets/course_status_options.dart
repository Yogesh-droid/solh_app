import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/features/lms/display/my_courses/ui/controllers/my_courses_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseStatusOptions extends StatelessWidget {
  CourseStatusOptions({super.key});

  final MyCoursesController myCoursesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(
            width: 12,
          ),
          FilterChip(
            backgroundColor: myCoursesController.selectedStatus.value == 'all'
                ? SolhColors.primary_green
                : SolhColors.grey_3,
            label: Text(
              'All',
              style: SolhTextStyles.CTA.copyWith(
                  color: myCoursesController.selectedStatus.value == 'all'
                      ? SolhColors.white
                      : SolhColors.black),
            ),
            onSelected: (bool value) {
              myCoursesController.selectedStatus.value = 'all';
              myCoursesController.getCourseMyCources();
            },
          ),
          const SizedBox(
            width: 12,
          ),
          FilterChip(
            backgroundColor:
                myCoursesController.selectedStatus.value == 'ongoing'
                    ? SolhColors.primary_green
                    : SolhColors.grey_3,
            label: Text(
              'Ongoing',
              style: SolhTextStyles.CTA.copyWith(
                  color: myCoursesController.selectedStatus.value == 'ongoing'
                      ? SolhColors.white
                      : SolhColors.black),
            ),
            onSelected: (bool value) {
              myCoursesController.selectedStatus.value = 'ongoing';
              myCoursesController.getCourseMyCources();
            },
          ),
          const SizedBox(
            width: 12,
          ),
          FilterChip(
            backgroundColor:
                myCoursesController.selectedStatus.value == 'completed'
                    ? SolhColors.primary_green
                    : SolhColors.grey_3,
            label: Text('Completed',
                style: SolhTextStyles.CTA.copyWith(
                    color:
                        myCoursesController.selectedStatus.value == 'completed'
                            ? SolhColors.white
                            : SolhColors.black)),
            onSelected: (bool value) {
              myCoursesController.selectedStatus.value = 'completed';
              myCoursesController.getCourseMyCources();
            },
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );
    });
  }
}
