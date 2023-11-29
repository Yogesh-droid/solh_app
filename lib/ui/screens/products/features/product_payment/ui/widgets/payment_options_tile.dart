import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PaymentOptionsTile extends StatelessWidget {
  const PaymentOptionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        'assets/images/get_help/stripe_icon.svg',
                        height: 50,
                      ),
                      const Text(
                        "Stripe",
                        style: SolhTextStyles.QS_body_1_med,
                      ),
                    ]),
                    const Radio(
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
