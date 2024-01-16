import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/course_faq_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CoursesFaqScreeen extends StatefulWidget {
  const CoursesFaqScreeen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<CoursesFaqScreeen> createState() => _CoursesFaqScreeenState();
}

class _CoursesFaqScreeenState extends State<CoursesFaqScreeen> {
  final CourseFaqController courseFaqController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseFaqController.getCourseFaq(widget.args['courseId']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: const Text(
              "FAQ's",
              style: SolhTextStyles.QS_body_2_semi,
            ),
            isLandingScreen: false,
            isVideoCallScreen: true),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Obx(() => courseFaqController.isLoading.value
              ? Center(
                  child: MyLoader(),
                )
              : courseFaqController.faqs.isEmpty
                  ? const Center(
                      child: Text(
                        "No Faqs",
                        style: SolhTextStyles.QS_body_2,
                      ),
                    )
                  : ListView.builder(
                      itemCount: courseFaqController.faqs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Flexible(
                                  child: Text(
                                    courseFaqController.faqs[index].question ??
                                        '',
                                    style:
                                        SolhTextStyles.QS_body_1_bold.copyWith(
                                            color: SolhColors.black),
                                  ),
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      decoration: BoxDecoration(
                                        color: SolhColors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                      child: Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            courseFaqController
                                                    .faqs[index].answer ??
                                                '',
                                            style: SolhTextStyles.QS_body_2_semi
                                                .copyWith(
                                                    color: SolhColors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      })),
        ));
  }
}
