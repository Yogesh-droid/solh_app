import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/bottom-navigation/profile_icon.dart';
import 'package:solh/features/lms/display/course_home/ui/controllers/course_banner_controller.dart';
import 'package:solh/features/lms/display/course_home/ui/controllers/course_cat_controller.dart';
import 'package:solh/features/lms/display/course_home/ui/controllers/feature_course_controller.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/category_container.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/course_banner.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/course_search_bar.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/recommended_course_container.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseHomePage extends StatefulWidget {
  const CourseHomePage({super.key});

  @override
  State<CourseHomePage> createState() => _CourseHomePageState();
}

class _CourseHomePageState extends State<CourseHomePage> {
  final FeaturedCourseController featuredCourseController = Get.find();
  final CourseCatController courseCatController = Get.find();
  final CourseBannerController courseBannerController = Get.find();

  @override
  void initState() {
    featuredCourseController.getFeaturedCourse(1);
    courseBannerController.getCourseHomeBanner();
    courseCatController.getCourseCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(10), child: CourseSearchBar()),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GetHelpDivider()),
            const CourseBanner(),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GetHelpDivider()),

            /// Categories
            GetHelpCategory(title: "Categories"),
            SizedBox(
              height: 175,
              child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: courseCatController.categoryList.length,
                  itemBuilder: (_, index) => CategoryContainer(
                      title: courseCatController.categoryList[index].name ?? '',
                      image: courseCatController
                              .categoryList[index].displayImage ??
                          '',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.courseListScreen,
                            arguments: {
                              "id": courseCatController.categoryList[index].id,
                              "name":
                                  courseCatController.categoryList[index].name,
                            });
                      },
                      index: index))),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GetHelpDivider()),

            /// Recommended Courses
            GetHelpCategory(
              title: "Recommended For You",
              onPressed: () {},
            ),
            SizedBox(
              height: 250,
              child: Obx(() => ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: featuredCourseController.featuredCourseList.length,
                  itemBuilder: (_, index) {
                    final course =
                        featuredCourseController.featuredCourseList[index];
                    return RecommendedCourseContainer(
                      title: course.title,
                      timeLength: course.totalDuration != null
                          ? "${course.totalDuration!.hours} hrs ${course.totalDuration!.minutes} mins"
                          : null,
                      price: course.price,
                      discountedPrice: course.afterDiscountPrice,
                      instructionName: course.instructor!.name,
                      isWishListed: course.isWishlisted,
                      onTap: () {},
                      id: course.id,
                      rating: course.rating,
                      image: course.thumbnail,
                      currency: course.currency,
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }

  getAppBar() {
    return ProductsAppBar(
        isLandingScreen: true,
        title: const ProfileIcon(),
        popupMenu: PopupMenuButton(
            child: const Icon(Icons.more_vert, color: SolhColors.primary_green),
            itemBuilder: (_) =>
                [PopupMenuItem(child: const Text("My Orders"), onTap: () {})]));
  }
}
