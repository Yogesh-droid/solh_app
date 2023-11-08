import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductStarWidget extends StatelessWidget {
  const ProductStarWidget({super.key, required this.rating});
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getStars(rating),
        SizedBox(
          width: 5,
        ),
        Text('$rating out of 5', style: SolhTextStyles.QS_body_2),
      ],
    );
  }
}

Widget _getStars(double rating) {
  return Row(
      children: List<Widget>.generate(
          5,
          (index) => Icon(
                Icons.star,
                size: 20,
                color: index < rating.toInt()
                    ? Colors.yellow[700]
                    : SolhColors.grey_2,
              )));
}
