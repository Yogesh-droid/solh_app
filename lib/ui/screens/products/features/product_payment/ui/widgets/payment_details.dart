import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails(
      {super.key,
      required this.total,
      required this.discount,
      required this.shipping});
  final double total;
  final double discount;
  final double shipping;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style:
                SolhTextStyles.QS_body_semi_1.copyWith(color: SolhColors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.dark_grey),
              ),
              Text(
                "₹ $total",
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.dark_grey),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items Discount',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
              Text(
                '- ₹ $discount',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.dark_grey),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Charge',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
              Text('₹ $shipping',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black),
              ),
              Text(
                '₹ ${total + shipping - discount}',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
