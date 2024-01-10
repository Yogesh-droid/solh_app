import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(userImage)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(useName,
                    style: GoogleFonts.quicksand(
                        textStyle: SolhTextStyles.QS_body_1_med.copyWith(
                            color: Colors.black))),
                Container(
                  width: 45,
                  height: 20,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: SolhColors.primary_green,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: SolhTextStyles.CTA
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
        const SizedBox(height: 20),
        Text(
          review ?? '',
          style: GoogleFonts.quicksand(
              textStyle:
                  SolhTextStyles.QS_body_2.copyWith(color: Colors.black)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
