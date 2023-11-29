import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class OrderListCard extends StatelessWidget {
  const OrderListCard(
      {super.key,
      this.status,
      required this.name,
      this.expectedDeliveryDate,
      required this.image,
      this.originalPrice,
      required this.quantity,
      required this.refId,
      required this.salePrice});

  final String? status;
  final String name;
  final int salePrice;
  final int? originalPrice;
  final int quantity;
  final String image;
  final String? expectedDeliveryDate;
  final String refId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              height: 130,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Item: $quantity',
                      style: SolhTextStyles.QS_caption,
                    ),
                    if (expectedDeliveryDate != null)
                      Text(
                        "Delivered By : ${DateFormat('dd MMM yyyy').format(DateTime.parse(expectedDeliveryDate!))}",
                        style: SolhTextStyles.QS_caption,
                      ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: SolhColors.primary_green,
                  ),
                ),
              ),
            )
          ],
        ),
        const Divider(),
        if (status != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getStatusColor(status!)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      status!,
                      style: SolhTextStyles.QS_caption,
                    ),
                  ],
                ),
                Text(
                  '₹ $salePrice',
                  style: SolhTextStyles.QS_caption_bold,
                )
              ],
            ),
          )
      ],
    );
  }
}

String getDeliveryString(String date) {
  if (DateTime.parse(date).isAfter(DateTime.now())) {
    return 'Delivery by ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(date))}';
  } else {
    return 'Delivered on ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(date))}';
  }
}

Color getStatusColor(String status) {
  if (status == "placed") {
    return Colors.yellow;
  } else if (status == "shipped") {
    return Colors.purple;
  } else if (status == "cancelled") {
    return Colors.red;
  } else {
    return Colors.green;
  }
}
