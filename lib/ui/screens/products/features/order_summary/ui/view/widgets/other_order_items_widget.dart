import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_detail_model.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class OtherOrderItemsWidget extends StatelessWidget {
  const OtherOrderItemsWidget({super.key, required this.otherItems});
  final OtherItems otherItems;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CachedNetworkImage(
        imageUrl: otherItems.image ?? '',
        height: 80,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
      const SizedBox(width: 10),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            otherItems.name ?? '',
            style: SolhTextStyles.QS_body_2_bold.copyWith(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
              "Delivery on ${DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(otherItems.expectedDeliveryDate!) ?? DateTime.now())}",
              style: SolhTextStyles.QS_caption)
        ],
      )),
      const Icon(
        Icons.keyboard_arrow_right,
        size: 30,
        color: SolhColors.primary_green,
      )
    ]);
  }
}
