import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails(
      {super.key,
      required this.total,
      required this.discount,
      required this.shipping,
      required this.currency,
      required this.currencySymbol});
  final double total;
  final double discount;
  final double shipping;
  final String currency;
  final String currencySymbol;

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
              Row(
                children: [
                  Text(
                    'Items Total',
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: SolhColors.dark_grey),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: SolhColors.greenShade4,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Saved $currencySymbol ${(total) - (total - discount)} ",
                      style: SolhTextStyles.Caption_2_semi.copyWith(
                          color: SolhColors.primary_green, fontSize: 7),
                    ),
                  )
                ],
              ),
              Row(children: [
                Text(
                  "$currencySymbol $total",
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey,
                      decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(width: 10),
                Text(
                  "$currencySymbol ${total - discount}",
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey),
                )
              ])
            ],
          ),
          /* const Divider(),
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
          ), */
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Charges',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
              Text('$currencySymbol $shipping',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black),
              ),
              Text(
                '$currencySymbol ${total + shipping - discount}',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: SolhColors.greenShade4,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/discount.svg",
                    colorFilter: const ColorFilter.mode(
                        SolhColors.primary_green, BlendMode.srcIn),
                  ),
                  Text(
                    "Yay! You Saved $currencySymbol $discount",
                    style: SolhTextStyles.Caption_2_semi.copyWith(
                        color: SolhColors.primary_green),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
