import 'package:flutter/material.dart';
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
                        expectedDeliveryDate!,
                        style: SolhTextStyles.QS_caption,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            )
          ],
        ),
        const Divider(),
        if (status != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
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
