import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

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
                imageUrl: 'https://picsum.photos/200',
                radius: 45,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amit Kumar',
                    style: SolhTextStyles.QS_body_1_med,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  _getReviewContainer(3.6)
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('Reviewed on 23 August 2023'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
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
