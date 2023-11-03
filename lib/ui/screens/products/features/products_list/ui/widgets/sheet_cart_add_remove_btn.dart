import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class SheetCartAddRemoveBtn extends StatelessWidget {
  const SheetCartAddRemoveBtn(
      {super.key,
      required this.increaseCartCount,
      required this.decreaseCartCount,
      required this.itemInCart,
      required this.id});

  final Function() increaseCartCount;
  final Function() decreaseCartCount;
  final int itemInCart;
  final String id;

  @override
  Widget build(BuildContext context) {
    final addToCartController = Get.find<AddToCartController>();
    final cartController = Get.find<CartController>();
    return Container(
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: SolhColors.grey_2),
      height: 25,
      child: Obx(() => addToCartController.addingToCart.value ||
              cartController.isCartLoading.value
          ? addToCartController.indexOfItemToBeUpdated.value == id
              ? SolhGradientLoader(
                  strokeWidth: 2,
                )
              : btnRow()
          : btnRow()),
    );
  }

  btnRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: decreaseCartCount,
            child: Icon(Icons.remove, color: SolhColors.black, size: 12),
          ),
          Text(itemInCart.toString(),
              style: GoogleFonts.quicksand(
                  textStyle: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.black, fontSize: 12))),
          InkWell(
            onTap: increaseCartCount,
            child: Icon(Icons.add, color: SolhColors.black, size: 12),
          )
        ]);
  }
}
