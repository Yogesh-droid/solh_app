import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_detail_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseLearning extends StatefulWidget {
  const CourseLearning({super.key});

  @override
  State<CourseLearning> createState() => _CourseLearningState();
}

class _CourseLearningState extends State<CourseLearning> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final CourseDetailController courseDetailController = Get.find();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
              data: courseDetailController
                      .courseDetailEntity.value.courseDetail!.courseLearning ??
                  '',
              shrinkWrap: true,
              style: {
                "body": Style(
                    padding: HtmlPaddings.zero,
                    margin: Margins.zero,
                    alignment: Alignment.topLeft,
                    height: isExpanded ? null : Height(100)),
                "p": Style(
                  fontSize: FontSize(12),
                )
              }),
          TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? "Show Less" : "Show More",
                style: const TextStyle(color: SolhColors.primary_green),
              ))
        ],
      ),
    );
  }
}
