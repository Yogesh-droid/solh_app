import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/add_course_to_cart_controller.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/controllers/add_remove_course_wishlist_item_controller.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/controllers/course_wishlist_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseWishlistCard extends StatelessWidget {
  CourseWishlistCard({
    super.key,
    required this.courseId,
    required this.imageUrl,
    required this.courseDurationHours,
    required this.courseDurationMinutes,
    required this.courseTitle,
    required this.currency,
    required this.instructorName,
    required this.price,
    required this.rating,
    required this.salePrice,
    required this.inCart,
  });
  final String courseId;
  final String imageUrl;
  final String courseTitle;
  final String instructorName;
  final int courseDurationHours;
  final int courseDurationMinutes;
  final double rating;
  final String currency;
  final int price;
  final int salePrice;
  final bool inCart;

  final AddRemoveCourseWishlistItemController
      addRemoveCourseWishlistItemController = Get.find();

  final AddCourseToCartController addCourseToCartController = Get.find();

  final CourseWishlistController courseWishlistController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.courseDetailScreen,
          arguments: {'id': courseId, 'name': courseTitle}),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: SolhColors.grey_2)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image.asset('assets/images/opening_link.gif'),
                imageUrl: imageUrl,
                width: 130,
                height: 140,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                height: 140,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseTitle,
                      style: SolhTextStyles.QS_cap_semi,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                          size: 12,
                          color: SolhColors.primaryRed,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          instructorName,
                          style: SolhTextStyles.QS_cap_2,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock,
                              color: SolhColors.primary_green,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                                "${courseDurationHours == 0 ? '' : ("${courseDurationHours}hrs")} ${courseDurationMinutes}mins",
                                style: SolhTextStyles.QS_cap_2),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_half_outlined,
                              color: Colors.amber[800],
                              size: 12,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              rating.toString(),
                              style: SolhTextStyles.QS_cap_2,
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text("$currency $salePrice",
                                    style: SolhTextStyles.QS_body_semi_1)
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                Text("$currency $price",
                                    style:
                                        SolhTextStyles.QS_body_semi_1.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: SolhColors.Grey_1)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                addRemoveCourseWishlistItemController
                                    .currentCourseRemoval = courseId;
                                await addRemoveCourseWishlistItemController
                                    .addRemoveCourseWishlistItem(courseId);

                                courseWishlistController
                                    .courseWishlist.value.courses!
                                    .removeWhere((element) {
                                  return courseId == element.sId;
                                });

                                courseWishlistController.courseWishlist
                                    .refresh();
                                Utility.showToast(
                                    addRemoveCourseWishlistItemController
                                        .message.value);
                              },
                              child: Obx(() {
                                return addRemoveCourseWishlistItemController
                                            .isLoading.value &&
                                        addRemoveCourseWishlistItemController
                                                .currentCourseRemoval ==
                                            courseId
                                    ? MyLoader(
                                        strokeWidth: 1,
                                        radius: 10,
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: SolhColors.org_color
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: SolhColors.primaryRed,
                                        ),
                                      );
                              }),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            inCart
                                ? const SizedBox(
                                    width: 38,
                                  )
                                : Obx(() {
                                    return addCourseToCartController
                                                .isAddingToCart.value &&
                                            addCourseToCartController
                                                    .currentUpdatingCourse ==
                                                courseId
                                        ? MyLoader(
                                            strokeWidth: 1,
                                            radius: 10,
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              addCourseToCartController
                                                      .currentUpdatingCourse =
                                                  courseId;
                                              await addCourseToCartController
                                                  .addToCart(courseId);
                                              int index =
                                                  courseWishlistController
                                                      .courseWishlist
                                                      .value
                                                      .courses!
                                                      .indexWhere((element) =>
                                                          element.sId ==
                                                          courseId);
                                              courseWishlistController
                                                  .courseWishlist
                                                  .value
                                                  .courses![index]
                                                  .inCart = true;
                                              courseWishlistController
                                                  .courseWishlist
                                                  .refresh();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: SolhColors.greenShade3
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Icon(
                                                  Icons
                                                      .add_shopping_cart_rounded,
                                                  color:
                                                      SolhColors.primary_green),
                                            ),
                                          );
                                  }),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
