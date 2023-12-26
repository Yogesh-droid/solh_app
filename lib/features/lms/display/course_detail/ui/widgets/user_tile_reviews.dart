import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class UserTileReviews extends StatelessWidget {
  const UserTileReviews(
      {super.key,
      required this.useName,
      required this.userImage,
      this.rating,
      this.review});
  final String useName;
  final String userImage;
  final int? rating;
  final String? review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(userImage)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(useName,
                    style: SolhTextStyles.QS_body_1_med.copyWith(
                        color: Colors.black)),
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: SolhColors.primary_green,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: SolhTextStyles.CTA.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
        const SizedBox(height: 10),
        Text(
          review ?? '',
          style: SolhTextStyles.QS_body_2.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
