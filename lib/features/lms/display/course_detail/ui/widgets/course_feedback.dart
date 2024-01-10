import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/star_widget_rating.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/user_tile_reviews.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseFeedback extends StatelessWidget {
  const CourseFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StarWidgetReviews(
                        totalStars: 5,
                        rating: courseDetailController
                            .courseDetailEntity.value.courseDetail!.rating
                            .toDouble()),
                    Text(
                        "  ${courseDetailController.courseDetailEntity.value.courseDetail!.rating} out of 5"),
                  ],
                ),
                Text(
                    "${courseDetailController.courseDetailEntity.value.totalReviews} Global Rating")
              ],
            ),
            const SizedBox(height: 40),
            ...courseDetailController.courseDetailEntity.value.reviews!.map(
                (e) => UserTileReviews(
                    useName: e.userId!.name ?? '',
                    userImage: e.userId!.profilePicture ?? '',
                    rating: e.rating,
                    review: e.review)),
            if (courseDetailController.courseDetailEntity.value.totalReviews! >
                3)
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.courseReviewsPage,
                        arguments: {
                          "id": courseDetailController
                                  .courseDetailEntity.value.courseDetail!.id ??
                              ''
                        });
                  },
                  child: Text('View More Reviews',
                      style: SolhTextStyles.CTA
                          .copyWith(color: SolhColors.primary_green)))
          ],
        ));
  }
}
