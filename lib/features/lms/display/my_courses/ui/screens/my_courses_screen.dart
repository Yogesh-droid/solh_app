import 'package:flutter/material.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/course_status_options.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/my_courses_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: const Text(
          'My Courses',
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            leadingWidth: 0,
            titleSpacing: 0,
            backgroundColor: SolhColors.white,
            title: SizedBox(
              height: 50,
              child: CourseStatusOptions(),
            ),
          ),
          SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: MyCoursesCard(),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
          )
        ],
      ),
    );
  }
}
