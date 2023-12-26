import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseWishlistCard extends StatelessWidget {
  const CourseWishlistCard({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: SolhColors.grey_2)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/200',
              width: 130,
              height: 140,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
