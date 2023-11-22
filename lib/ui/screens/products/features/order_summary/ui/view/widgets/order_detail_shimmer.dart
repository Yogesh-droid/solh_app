import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../../products_list/ui/widgets/shimmer_widget.dart';

class OrderDetailShimmer extends StatelessWidget {
  const OrderDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // upper portion
            const ShimmerWidget(
              height: 20,
              child: Text(
                "Payment Details",
                style: SolhTextStyles.QS_body_semi_1,
              ),
            ),
            const SizedBox(height: 20),
            linearShimmer(),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerWidget(
                  height: 20,
                  child: Text(
                    "Product Details",
                    style: SolhTextStyles.QS_body_semi_1,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ShimmerWidget(
                      height: 150,
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: linearShimmer()),
                  ],
                ),
                const SizedBox(height: 30),
                // Stepper
                const ShimmerWidget(
                  height: 30,
                  child: Text(
                    "Order Tracking",
                    style: SolhTextStyles.QS_body_semi_1,
                  ),
                ),
                ShimmerWidget(
                  child: Stepper(steps: const [
                    Step(title: Text("Progress"), content: SizedBox()),
                    Step(title: Text("Progress"), content: SizedBox()),
                    Step(title: Text("Progress"), content: SizedBox()),
                    Step(title: Text("Progress"), content: SizedBox())
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget linearShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
            height: 20,
            child: Container(
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)))),
        const SizedBox(height: 10),
        ShimmerWidget(
            height: 20,
            child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)))),
        const SizedBox(height: 10),
        ShimmerWidget(
            height: 20,
            child: Container(
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)))),
        const SizedBox(height: 10),
        ShimmerWidget(
          height: 20,
          child: Container(
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20))),
        ),
      ],
    );
  }
}
