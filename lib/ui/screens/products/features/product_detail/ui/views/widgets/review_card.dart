import 'package:flutter/material.dart';
import 'package:solh/ui/screens/psychology-test/test_history_details.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.review,
    this.reviewedAt,
  });
  final String? imageUrl;
  final String? name;
  final double? rating;
  final String? reviewedAt;
  final String? review;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleImageContainer(
                imageUrl: imageUrl ?? '',
                radius: 45,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: SolhTextStyles.QS_body_1_med,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  _getReviewContainer(rating ?? 0)
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('Reviewed ${timeago.format(DateTime.parse(reviewedAt!))}'),
          SizedBox(
            height: 10,
          ),
          Text(
            review ?? '',
            style: SolhTextStyles.QS_body_2.copyWith(color: SolhColors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: SolhColors.grey239,
          ),
        ],
      ),
    );
  }
}

Widget _getReviewContainer(double rating) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: _getColor(rating),
    ),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    child: Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: SolhColors.white,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          '$rating',
          style:
              SolhTextStyles.QS_caption_bold.copyWith(color: SolhColors.white),
        ),
      ],
    ),
  );
}

Color _getColor(double rating) {
  if (rating <= 3.5 && rating >= 2.5) {
    return Colors.yellow[700]!;
  } else if (rating < 2.5) {
    return SolhColors.primaryRed;
  } else {
    return SolhColors.primary_green;
  }
}
