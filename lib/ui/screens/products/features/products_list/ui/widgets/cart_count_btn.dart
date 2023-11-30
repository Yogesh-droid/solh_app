import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../../widgets_constants/constants/colors.dart';

class CartCountBtn extends StatelessWidget {
  const CartCountBtn(
      {super.key,
      required this.increaseCartCount,
      required this.decreaseCartCount,
      required this.itemInCart});
  final Function() increaseCartCount;
  final Function() decreaseCartCount;
  final int itemInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      child: Row(children: [
        Obx(() => InkWell(
              onTap: Get.find<AddToCartController>().addingToCart.value
                  ? null
                  : decreaseCartCount,
              child: Container(
                  height: 30,
                  color: SolhColors.primary_green,
                  child: const Icon(Icons.remove, color: SolhColors.white)),
            )),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green)),
          width: 30,
          child: Center(
              child: Text(itemInCart.toString(),
                  style: GoogleFonts.quicksand(
                      textStyle: SolhTextStyles.QS_body_semi_1.copyWith(
                          color: SolhColors.primary_green)))),
        ),
        Obx(() => InkWell(
              onTap: Get.find<AddToCartController>().addingToCart.value
                  ? null
                  : increaseCartCount,
              child: Container(
                height: 30,
                color: SolhColors.primary_green,
                child: const Icon(Icons.add, color: SolhColors.white),
              ),
            ))
      ]),
    );
  }
}
