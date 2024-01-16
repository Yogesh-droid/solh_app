import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/wish_list_icon.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class RecommendedCourseContainer extends StatelessWidget {
  const RecommendedCourseContainer(
      {super.key,
      this.onTap,
      this.isWishListed,
      this.onWishListTapped,
      this.title,
      this.instructionName,
      this.timeLength,
      this.rating,
      this.price,
      this.discountedPrice,
      this.image,
      this.currency,
      this.id});
  final Function()? onTap;
  final bool? isWishListed;
  final Function()? onWishListTapped;
  final String? title;
  final String? instructionName;
  final String? timeLength;
  final double? rating;
  final String? id;
  final int? price;
  final int? discountedPrice;
  final String? image;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.courseDetailScreen,
          arguments: {'id': id, 'name': title,"thumbnail": image}),
     
          child: Container(
            width: 185,
            decoration: BoxDecoration(
              border: Border.all(color: SolhColors.grey_2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
               mainAxisAlignment:MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: image!,
                  height: 120,
                  width: 185,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
            
                  mainAxisAlignment:MainAxisAlignment.start ,children:[
                  Text(
                    title ?? '',
                    style: SolhTextStyles.QS_cap_2_semi.copyWith(
                        color: Colors.black, fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  // Instructor Name
                  Row(children: [
                    const Icon(
                      Icons.person_2_outlined,
                      size: 12,
                      color: SolhColors.primaryRed,
                    ),
                    Text(
                      instructionName ?? '',
                      style: SolhTextStyles.QS_cap_2,
                      maxLines: 1,
                    )
                  ]),
                  const SizedBox(height: 5),
                  // Time And Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (timeLength != null)
                        Row(children: [
                          const Padding(
                            padding: EdgeInsets.all(3),
                            child: Icon(Icons.access_time,
                                color: SolhColors.primary_green, size: 12),
                          ),
                          Text(
                            timeLength ?? '',
                            style: SolhTextStyles.QS_cap_2,
                          )
                        ]),
                      if (rating != null)
                        Row(children: [
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(Icons.star_half_outlined,
                                color: Color(0xFFFFCC4D), size: 12),
                          ),
                          Text(
                            "$rating",
                            style: SolhTextStyles.QS_cap_2,
                          )
                        ]),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Price and discounted price
                  Row(
                    children: [
                      Text(
                        "$currency $price",
                        style: SolhTextStyles.QS_body_semi_1,
                      ),
                      const SizedBox(width: 5),
                      if (discountedPrice != null)
                        Text(
                          "$currency $discountedPrice",
                          style: SolhTextStyles.QS_body_2.copyWith(
                              decoration: TextDecoration.lineThrough),
                        )
                    ],
                  )
                ]),
              )
            ]),
          ),
        ),
        Positioned(
            right: 0,
            child: WishListIcon(
                onTap: onWishListTapped!,
                iconData: isWishListed!
                    ? const Icon(Icons.favorite_rounded,
                        color: SolhColors.primaryRed)
                    : const Icon(Icons.favorite_outline))),
      ],
    );
  }
}
