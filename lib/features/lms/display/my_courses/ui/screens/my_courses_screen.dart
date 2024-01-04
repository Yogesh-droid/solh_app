import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/features/lms/display/my_courses/ui/controllers/my_courses_controller.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/course_status_options.dart';
import 'package:solh/features/lms/display/my_courses/ui/widgets/my_courses_card.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  MyCoursesController myCoursesController = Get.find();
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myCoursesController.getCourseMyCources();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            myCoursesController.isLoading.value == false &&
            myCoursesController.isEnd.value == false) {
          log(myCoursesController.isEnd.value.toString(),
              name: "myCoursesController.isEnd.value");
          myCoursesController.getCourseMyCources();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    myCoursesController.isEnd.value = false;
    myCoursesController.nextPage = 1;
    super.dispose();
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
                controller: scrollController,
                slivers: [
                  SliverAppBar(
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
                  myCoursesController.myCoursesModel.value.myCourseList!.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: const Text(
                              "No item found",
                              style: SolhTextStyles.CTA,
                            ),
                          )),
                        )
                      : SliverList.separated(
                          itemCount: myCoursesController
                              .myCoursesModel.value.myCourseList!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: MyCoursesCard(
                              courseId: myCoursesController.myCoursesModel.value
                                      .myCourseList![index].courseId ??
                                  '',
                              courseDurationHours: myCoursesController
                                  .myCoursesModel
                                  .value
                                  .myCourseList![index]
                                  .totalDuration!
                                  .hours
                                  .toString(),
                              courseDurationMins: myCoursesController
                                  .myCoursesModel
                                  .value
                                  .myCourseList![index]
                                  .totalDuration!
                                  .minutes
                                  .toString(),
                              imageUrl: myCoursesController.myCoursesModel.value
                                  .myCourseList![index].image
                                  .toString(),
                              progressPercent: myCoursesController
                                  .myCoursesModel
                                  .value
                                  .myCourseList![index]
                                  .progressStatus
                                  .toString(),
                              title: myCoursesController.myCoursesModel.value
                                  .myCourseList![index].courseName
                                  .toString(),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                        ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return myCoursesController.isMoreLoading.value
                              ? const ButtonLoadingAnimation()
                              : Container(
                                  padding: const EdgeInsets.only(bottom: 16),
                                );
                        }),
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}
