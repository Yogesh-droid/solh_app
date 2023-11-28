import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ItemDetailCancelOrder extends StatelessWidget {
  const ItemDetailCancelOrder(
      {super.key,
      required this.itemName,
      required this.quantity,
      required this.image,
      required this.price});
  final String itemName;
  final String quantity;
  final String image;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 1, child: CachedNetworkImage(imageUrl: image)),
        const SizedBox(width: 20),
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: GoogleFonts.quicksand(
                      textStyle: SolhTextStyles.QS_body_2_bold.copyWith(
                          color: Colors.black)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text("item: $quantity", style: SolhTextStyles.QS_caption),
                const SizedBox(height: 5),
                Text(price, style: SolhTextStyles.QS_caption_bold),
                const SizedBox(height: 10)
              ],
            ))
      ]),
    );
  }
}
