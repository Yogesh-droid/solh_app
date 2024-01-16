import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_listing/ui/controllers/course_list_controller.dart';
import 'package:solh/features/lms/display/course_listing/ui/widgets/course_list_tile.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/controllers/add_remove_course_wishlist_item_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final CourseListController courseListController = Get.find();
  final AddRemoveCourseWishlistItemController
      addRemoveCourseWishlistItemController =
      Get.find<AddRemoveCourseWishlistItemController>();

  @override
  void initState() {
    getCourseList(widget.args['id'], 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Hero(
              tag: widget.args['id'],
              child: Text(
                widget.args['name'],
                style: SolhTextStyles.QS_body_semi_1,
              ),
            ),
          ),
          isLandingScreen: false,
          isVideoCallScreen: true,
        ),
        body: Obx(() => courseListController.isLoading.value
            ? const ProductListShimmer()
            : courseListController.courseList.isEmpty
                ? Center(
                    child: Text(
                    "No Items Found",
                    style: SolhTextStyles.QS_big_body.copyWith(
                      color: SolhColors.grey_3,
                    ),
                  ))
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: courseListController.courseList.length,
                    itemBuilder: (context, index) {
                      final course = courseListController.courseList[index];
                      return CourseListTile(
                        currency: course.currency,
                        discountedPrice: course.afterDiscountPrice,
                        image: course.thumbnail,
                        id: course.id,
                        instructorName: course.instructor!.name,
                        isWishListed: course.isWishlisted,
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.courseDetailScreen,
                              arguments: {
                                "id": course.id,
                                "name": course.title,
                                "thumbnail": course.thumbnail
                              });
                        },
                        price: course.price,
                        rating: course.rating,
                        timeLength: course.totalDuration != null
                            ? "${course.totalDuration!.hours} hrs ${course.totalDuration!.minutes} mins"
                            : null,
                        title: course.title,
                        onWishListTapped: () async {
                          await addRemoveCourseWishlistItemController
                              .addRemoveCourseWishlistItem(course.id ?? '');
                          if (addRemoveCourseWishlistItemController
                              .isAdded.value) {
                            courseListController
                                .courseList[index].isWishlisted = true;
                            courseListController.courseList.refresh();
                          } else {
                            courseListController
                                .courseList[index].isWishlisted = false;
                            courseListController.courseList.refresh();
                          }
                        },
                      );
                    })));
  }

  Future<void> getCourseList(String id, int pageNo) async {
    await courseListController.getCourseList(id, pageNo);
  }
}
