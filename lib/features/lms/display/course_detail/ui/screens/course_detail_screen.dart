import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/course_leanring.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/duration_lang.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/instructor_rating.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/price_discount.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/video_preview_widget.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
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

  @override
  void initState() {
    getCourseDetails(widget.args['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          const CourseLearning(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: GetHelpDivider(),
                          ),

                          ///
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
