import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:video_trimmer/video_trimmer.dart';

class OrderListCard extends StatelessWidget {
  OrderListCard(
      {super.key,
      required this.status,
      required this.name,
      required this.expectedDeliveryDate,
      required this.image,
      required this.originalPrice,
      required this.quantity,
      required this.refId,
      required this.salePrice});

  String status;
  String name;
  int salePrice;
  int originalPrice;
  int quantity;
  String image;
  String expectedDeliveryDate;
  String refId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Image.network(
                  image,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
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
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Item: $quantity',
                        style: SolhTextStyles.QS_caption,
                      ),
                      Text(
                        getDeliveryString(expectedDeliveryDate),
                        style: SolhTextStyles.QS_caption,
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 100,
              //   child: Center(
              //     child: Icon(
              //       Icons.arrow_forward_ios_rounded,
              //     ),
              //   ),
              // )
            ],
          ),
          Divider(),
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
                          color: getStatusColor(status)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      status,
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
      ),
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
