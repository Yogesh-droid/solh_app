import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PaymentOptionsTile extends StatelessWidget {
  const PaymentOptionsTile({super.key, this.horizontalPadding});
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 24, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Payment Options",
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black)),
            const SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: SolhColors.primary_green),
                  borderRadius: BorderRadius.circular(10)),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          CupertinoIcons.creditcard_fill,
                          size: 20,
                          color: SolhColors.primary_green,
                        ),
                      ),
                      Text(
                        "Card payment",
                        style: SolhTextStyles.QS_body_1_med,
                      ),
                    ]),
                    Radio(
                        groupValue: 1,
                        value: 1,
                        onChanged: null,
                        fillColor:
                            MaterialStatePropertyAll(SolhColors.primary_green)),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
