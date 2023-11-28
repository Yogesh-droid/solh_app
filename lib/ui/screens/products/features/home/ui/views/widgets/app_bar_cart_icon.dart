import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../../../../../routes/routes.dart';
import '../../../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../../../widgets_constants/constants/textstyles.dart';
import '../../../../cart/ui/controllers/add_to_cart_controller.dart';
import '../../../../cart/ui/controllers/cart_controller.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.itemsInCart});

  final int itemsInCart;
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final AddToCartController addToCartController = Get.find();

    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.checkoutScreen, arguments: {
        "onDecrease": (index, id, quantity) async {
          //  Id saved in controller so that we can check on which item we need to show loader//
          Get.find<AddToCartController>().indexOfItemToBeUpdated.value =
              cartController
                  .cartEntity.value.cartList!.items![index].productId!.id!;
          //////////////
          await addToCartController.addToCart(
              productId: id, quantity: quantity - 1);
          await cartController.getCart();
        },
        "onIncrease": (index, id, quantity) async {
          //  Id saved in controller so that we can check on which item we need to show loader//
          Get.find<AddToCartController>().indexOfItemToBeUpdated.value =
              cartController
                  .cartEntity.value.cartList!.items![index].productId!.id!;
          //////////////
          await addToCartController.addToCart(
              productId: id, quantity: quantity + 1);

          await cartController.getCart();
        }
      }),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  CupertinoIcons.cart,
                  color: SolhColors.primary_green,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: SolhColors.primary_green),
                  child: Text(itemsInCart.toString(),
                      style: SolhTextStyles.QS_caption_2_bold.copyWith(
                        color: SolhColors.white,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
