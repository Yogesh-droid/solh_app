import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/buttons/primary-buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_cart.png'),
          const SizedBox(height: 20),
          Text(
            "Oops! Your Cart is Empty",
            style: SolhTextStyles.QS_body_1_bold.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 20),
          SolhGreenBtn48(
              onPress: () {
                print("On Pressed");
                Navigator.pop(context);
              },
              text: "Shop Now")
        ],
      ),
    );
  }
}
