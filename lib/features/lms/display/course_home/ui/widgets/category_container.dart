import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap,
      required this.index,
      this.id});
  final String title;
  final String image;
  final Function() onTap;
  final int index;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: index.isEven
                  ? const Color(0xFFFFC6C5)
                  : const Color(0xFFD6F4DC)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: Hero(
                  tag: id ?? '',
                  child: Text(
                    title,
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(child: CachedNetworkImage(imageUrl: image))
            ],
          ),
        ),
      ),
    );
  }
}
