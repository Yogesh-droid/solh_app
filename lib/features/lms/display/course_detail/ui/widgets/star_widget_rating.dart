import 'package:flutter/material.dart';

class StarWidgetReviews extends StatelessWidget {
  const StarWidgetReviews(
      {super.key, required this.totalStars, required this.rating});
  final int totalStars;
  final double rating;

  @override
  Widget build(BuildContext context) {
    var isInt = rating.isInteger;
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rating.toInt(),
              itemBuilder: (_, __) =>
                  const Icon(Icons.star, color: Colors.orange)),
          if (!isInt) const Icon(Icons.star_half, color: Colors.orange),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: totalStars - (rating.toInt()),
              itemBuilder: (_, __) => const Icon(Icons.star_border)),
        ],
      ),
    );
  }
}

extension numExtension on num {
  bool get isInteger => (this % 1) == 0;
  bool get isDecimal => (this % 1) != 1;
}
