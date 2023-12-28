import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseCartItemsTile extends StatelessWidget {
  const CourseCartItemsTile(
      {super.key,
      this.image,
      required this.onTap,
      this.title,
      this.price,
      this.currency,
      required this.onDeleteTap,
      this.discountedPrice});
  final String? image;
  final Function() onTap;
  final String? title;
  final int? price;
  final int? discountedPrice;
  final String? currency;
  final Function() onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: SolhColors.grey239),
          borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            child: CachedNetworkImage(
                imageUrl: image ?? '',
                width: 100,
                height: 100,
                fit: BoxFit.fill)),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style:
                      SolhTextStyles.QS_cap_semi.copyWith(color: Colors.black),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text("$currency $price",
                        style: SolhTextStyles.QS_body_semi_1.copyWith(
                            color: Colors.black)),
                    const SizedBox(width: 10),
                    Text("$currency $discountedPrice",
                        style: SolhTextStyles.QS_body_semi_1.copyWith(
                            decoration: TextDecoration.lineThrough))
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ]),
        ),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: SolhColors.Tertiary_Red,
                  borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                  onPressed: onDeleteTap,
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: SolhColors.primaryRed,
                  )),
            )),
        const SizedBox(width: 10)
      ]),
    );
  }
}
