import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/add_course_to_cart_controller.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/add_to_cart_bottom_nav.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/course_content.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/course_feedback.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/course_includes.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/duration_lang.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/instructor_details.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/instructor_rating.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/price_discount.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/video_preview_widget.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final CourseDetailController courseDetailController = Get.find();
  final AddCourseToCartController addCourseToCartController = Get.find();

  @override
  void initState() {
    getCourseDetails(widget.args['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => courseDetailController.isLoading.value
            ? const SizedBox.shrink()
            : AddToCartBottomNav(
                title: courseDetailController
                        .courseDetailEntity.value.courseDetail!.isInCart!
                    ? "Go To Checkout"
                    : "Add To Cart",
                onTap: courseDetailController
                        .courseDetailEntity.value.courseDetail!.isInCart!
                    ? () {
                        Navigator.pushNamed(
                            context, AppRoutes.courseCheckoutScreen);
                      }
                    : () async {
                        await addCourseToCartController.addToCart(
                            courseDetailController.courseDetailEntity.value
                                    .courseDetail!.id ??
                                '');
                        if (addCourseToCartController.isAddedToCart.value) {
                          courseDetailController.courseDetailEntity.value
                              .courseDetail!.isInCart = true;
                          courseDetailController.courseDetailEntity.refresh();
                        } else {
                          courseDetailController.courseDetailEntity.value
                              .courseDetail!.isInCart = false;
                          courseDetailController.courseDetailEntity.refresh();
                        }
                      })),
        appBar: SolhAppBar(
            title: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                widget.args['name'],
                style: SolhTextStyles.QS_body_semi_1,
              ),
            ),
            isLandingScreen: false,
            isVideoCallScreen: true),
        body: Obx(() => courseDetailController.isLoading.value
            ? MyLoader()
            : Column(children: [
                VideoPreviewWidget(
                  url: courseDetailController
                          .courseDetailEntity.value.courseDetail!.preview ??
                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            courseDetailController.courseDetailEntity.value
                                    .courseDetail!.title ??
                                '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 10),

                          /// Subtitle
                          Text(
                            courseDetailController.courseDetailEntity.value
                                    .courseDetail!.subTitle ??
                                '',
                            style: SolhTextStyles.QS_caption,
                          ),
                          const SizedBox(height: 10),

                          /// Instructor And Rating
                          const InstructorRating(),

                          /// Duration And Language
                          const DurationLang(),

                          /// Price and Discount
                          const SizedBox(height: 5),
                          const PriceDiscount(),

                          /// What You Will Learn Course Learnings
                          const SizedBox(height: 20),
                          Text(
                            "What you'll learn",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          CourseIncludes(
                              data: courseDetailController.courseDetailEntity
                                      .value.courseDetail!.courseLearning ??
                                  ''),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GetHelpDivider(),
                          ),

                          /// Course Content
                          const SizedBox(height: 10),
                          Text(
                            "Course Content",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 5),
                          const CourseContent(),
                          const SizedBox(height: 10),

                          /// Show More Button
                          if (courseDetailController
                                  .courseDetailEntity.value.sections!.length >
                              5)
                            SolhGreenBorderButton(
                                borderRadius: BorderRadius.zero,
                                child: Text(
                                  "${courseDetailController.courseDetailEntity.value.sections!.length - 5} More Module",
                                  style: SolhTextStyles.QS_cap_semi.copyWith(
                                      color: SolhColors.primary_green),
                                )),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GetHelpDivider(),
                          ),

                          /// Course includes
                          const SizedBox(height: 10),
                          Text(
                            "This Course Includes",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 5),
                          CourseIncludes(
                              data: courseDetailController.courseDetailEntity
                                      .value.courseDetail!.courseIncludes ??
                                  ''),

                          /// Course desciption

                          const SizedBox(height: 10),
                          Text(
                            "Description",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 5),
                          CourseIncludes(
                              data: courseDetailController.courseDetailEntity
                                      .value.courseDetail!.description ??
                                  ''),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GetHelpDivider(),
                          ),
                          // Instructor details
                          const SizedBox(height: 10),
                          Text(
                            "Instructor",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 5),
                          const InstructorDetails(),

                          // Reviews

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GetHelpDivider(),
                          ),
                          // Instructor details
                          const SizedBox(height: 10),
                          Text(
                            "Course Feedback",
                            style: SolhTextStyles.QS_body_1_med.copyWith(
                                color: const Color(0xFF2E2E2E)),
                          ),
                          const SizedBox(height: 5),
                          const CourseFeedback(),
                          const SizedBox(height: 200)
                        ],
                      ),
                    ),
                  ),
                )
              ])));
  }

  void getCourseDetails(id) {
    courseDetailController.getCourseDetail(widget.args['id']);
  }
}
