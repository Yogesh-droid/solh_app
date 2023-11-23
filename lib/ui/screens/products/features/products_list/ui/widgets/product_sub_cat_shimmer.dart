import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductSubCatShimmer extends StatelessWidget {
  const ProductSubCatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}
