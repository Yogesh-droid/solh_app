import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_detail/ui/controllers/course_review_controller.dart';
import 'package:solh/features/lms/display/course_detail/ui/widgets/user_tile_reviews.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AllReviewsPage extends StatefulWidget {
  const AllReviewsPage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<AllReviewsPage> createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  final CourseReviewController courseReviewController = Get.find();
  late ScrollController scrollController;
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    getReviews();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!courseReviewController.isLoading.value &&
            !courseReviewController.isLast.value) {
          getReviews();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          title: Obx(() => Text(
                'All Reviews (${courseReviewController.reviewList.length})',
                style: SolhTextStyles.QS_body_semi_1,
              )),
          isLandingScreen: false,
          isVideoCallScreen: true),
      body: Obx(() => courseReviewController.isLoading.value
          ? const ProductListShimmer()
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: courseReviewController.reviewList.length,
                        itemBuilder: ((context, index) {
                          return UserTileReviews(
                              useName: courseReviewController
                                      .reviewList[index].userId!.name ??
                                  '',
                              userImage: courseReviewController
                                      .reviewList[index]
                                      .userId!
                                      .profilePicture ??
                                  '',
                              rating: courseReviewController
                                  .reviewList[index].rating,
                              review: courseReviewController
                                  .reviewList[index].review);
                        })),
                    if (courseReviewController.isLoadingMore.value)
                      const Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            )),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void getReviews() {
    courseReviewController.getReviews(
        courseId: widget.args['id'], pageNo: pageNo);
    pageNo++;
  }
}
