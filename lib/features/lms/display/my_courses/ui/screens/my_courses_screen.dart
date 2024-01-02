import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/features/lms/display/my_courses/ui/controllers/my_courses_controller.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/course_status_options.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/my_courses_card.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  MyCoursesController myCoursesController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myCoursesController.getCourseMyCources();
    });

    super.initState();
  }

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
      body: Obx(() {
        return myCoursesController.isLoading.value
            ? const ProductListShimmer()
            : CustomScrollView(
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
                    itemCount: myCoursesController
                        .myCoursesModel.value.myCourseList!.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: MyCoursesCard(
                        courseId: myCoursesController.myCoursesModel.value
                                .myCourseList![index].courseId ??
                            '',
                        courseDuration: myCoursesController.myCoursesModel.value
                            .myCourseList![index].totalDuration
                            .toString(),
                        imageUrl: myCoursesController
                            .myCoursesModel.value.myCourseList![index].image
                            .toString(),
                        progressPercent: myCoursesController.myCoursesModel
                            .value.myCourseList![index].progressStatus
                            .toString(),
                        title: myCoursesController.myCoursesModel.value
                            .myCourseList![index].courseName
                            .toString(),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                  )
                ],
              );
      }),
    );
  }
}
