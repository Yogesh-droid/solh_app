import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/controllers/course_wishlist_controller.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/widgets/course_wishlist_card.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/screen/product_wishlist_screen.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseWishlist extends StatefulWidget {
  const CourseWishlist({super.key});

  @override
  State<CourseWishlist> createState() => _CourseWishlistState();
}

class _CourseWishlistState extends State<CourseWishlist>
    with AutomaticKeepAliveClientMixin {
  final CourseWishlistController courseWishlistController = Get.find();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    courseWishlistController.getCourseWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return courseWishlistController.isLoading.value
          ? MyLoader()
          : SmartRefresher(
              controller: refreshController,
              onRefresh: () async =>
                  courseWishlistController.getCourseWishList(),
              child:
                  courseWishlistController.courseWishlist.value.courses!.isEmpty
                      ? const EmptyWishListWidget()
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: courseWishlistController
                              .courseWishlist.value.courses!.length,
                          itemBuilder: (context, index) => CourseWishlistCard(
                            inCart: courseWishlistController.courseWishlist
                                    .value.courses![index].inCart ??
                                true,
                            courseId: courseWishlistController
                                    .courseWishlist.value.courses![index].sId ??
                                '',
                            imageUrl: courseWishlistController.courseWishlist
                                    .value.courses![index].thumbnail ??
                                '',
                            courseTitle: courseWishlistController.courseWishlist
                                    .value.courses![index].title ??
                                '',
                            courseDurationHours: courseWishlistController
                                    .courseWishlist
                                    .value
                                    .courses![index]
                                    .totalDuration!
                                    .hours ??
                                0,
                            courseDurationMinutes: courseWishlistController
                                    .courseWishlist
                                    .value
                                    .courses![index]
                                    .totalDuration!
                                    .minutes ??
                                0,
                            currency: courseWishlistController.courseWishlist
                                    .value.courses![index].currency ??
                                '',
                            instructorName: courseWishlistController
                                    .courseWishlist
                                    .value
                                    .courses![index]
                                    .instructor!
                                    .name ??
                                '',
                            price: courseWishlistController.courseWishlist.value
                                    .courses![index].price ??
                                0,
                            rating: courseWishlistController.courseWishlist
                                    .value.courses![index].rating ??
                                0.0,
                            salePrice: courseWishlistController.courseWishlist
                                    .value.courses![index].salePrice ??
                                0,
                          ),
                        ),
            );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
