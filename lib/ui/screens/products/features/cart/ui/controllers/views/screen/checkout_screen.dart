import 'package:flutter/material.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/in_cart_product_item_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Your Cart',
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "4 Items in your cart",
                      style: SolhTextStyles.QS_body_2_semi,
                    ),
                    Text(
                      "+ Add more items",
                      style: SolhTextStyles.QS_body_2_semi.copyWith(
                          color: SolhColors.primary_green),
                    )
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) {
                  return GetHelpDivider();
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InCartProductItemCard(),
                  );
                },
              ),
              GetHelpDivider(),
              PaymentSummarySection(),
              SizedBox(
                height: 80,
              ),
            ],
          ),
          Positioned(bottom: 0, right: 0, left: 0, child: CheckoutButton())
        ],
      ),
    );
  }
}

class PaymentSummarySection extends StatelessWidget {
  const PaymentSummarySection({super.key});

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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order total',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.dark_grey),
              ),
              Text('₹ 490',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items discount',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
              Text('- ₹ 50',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Charge',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
              Text('₹ 50',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black),
              ),
              Text(
                '₹ 490',
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

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          color: SolhColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Price",
                style: SolhTextStyles.QS_body_semi_1,
              ),
              Text(
                "₹ 490",
                style:
                    SolhTextStyles.QS_head_5.copyWith(color: SolhColors.black),
              ),
            ],
          ),
          SolhGreenMiniButton(
            child: Text(
              'Checkout',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          )
        ],
      ),
    );
  }
}
