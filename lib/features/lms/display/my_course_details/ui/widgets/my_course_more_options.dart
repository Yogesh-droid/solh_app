import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/my_course_detail_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCourseMoreOptions extends StatelessWidget {
  const MyCourseMoreOptions({super.key, required this.courseId});
  final String courseId;

  @override
  Widget build(BuildContext context) {
    final MyCourseDetailController myCourseDetailController = Get.find();
    return SingleChildScrollView(
      child: Column(
        children: [
          OptionsTile(
            icon: Icons.info_outline,
            onTap: () {},
            title: "About This Course",
          ),
          OptionsTile(
            icon: Icons.message,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.courseChatPage,
                  arguments: {
                    'courseId': courseId,
                  });
            },
            title: "Message",
          ),
          OptionsTile(
            icon: Icons.help_outline,
            onTap: () {
              if (myCourseDetailController.certificateUrl.value.isEmpty) {
                showAlert(context);
              } else {
                Navigator.pushNamed(context, AppRoutes.certificatePage,
                    arguments: {
                      "imageUrl": myCourseDetailController.certificateUrl.value
                    });
              }
            },
            title: "Course Certificate",
          ),
          OptionsTile(
            icon: Icons.download,
            onTap: () {},
            title: "Resources",
          ),
          OptionsTile(
            icon: Icons.rate_review_outlined,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.addReviewPage, arguments: {
                'courseId': courseId,
              });
            },
            title: "Add Review",
          ),
          OptionsTile(
            icon: Icons.assignment_turned_in,
            onTap: () {},
            title: "Assignment",
          ),
          OptionsTile(
            icon: Icons.question_answer_outlined,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.coursesFaqScreen,
                  arguments: {
                    'courseId': courseId,
                  });
            },
            title: "FAQ's",
          ),
        ],
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              AlertDialog(
                actionsPadding: const EdgeInsets.all(8.0),
                content: Text(
                  'Finish all lectures to access your certificate. Open first incomplete lecture? '
                      .tr,
                  style: SolhTextStyles.JournalingDescriptionText,
                ),
                actions: [
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Open Lecture'.tr,
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primaryRed),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(width: 30),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel'.tr,
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primary_green),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(false);
                      }),
                ],
              ),
            ],
          );
        });
  }
}

class OptionsTile extends StatelessWidget {
  const OptionsTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.quicksand(
            textStyle: SolhTextStyles.CTA.copyWith(color: Colors.black)),
      ),
      leading: Icon(
        icon,
        color: SolhColors.primary_green,
      ),
      onTap: onTap,
    );
  }
}
