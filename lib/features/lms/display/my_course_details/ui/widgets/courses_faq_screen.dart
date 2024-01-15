import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CoursesFaqScreeen extends StatefulWidget {
  const CoursesFaqScreeen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<CoursesFaqScreeen> createState() => _CoursesFaqScreeenState();
}

class _CoursesFaqScreeenState extends State<CoursesFaqScreeen> {
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
    );
  }
}
