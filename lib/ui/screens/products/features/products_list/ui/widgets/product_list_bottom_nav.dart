import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/sheet_cart_item.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../../routes/routes.dart';

class ProductListBottomNav extends StatefulWidget {
  const ProductListBottomNav(
      {super.key,
      required this.noOfItemsInCart,
      required this.onIncreaseCartCount,
      required this.onDecreaseCartCount});
  final int noOfItemsInCart;
  final Function(int index, String id, int quantity) onIncreaseCartCount;
  final Function(int index, String id, int quantity) onDecreaseCartCount;

  @override
  State<ProductListBottomNav> createState() => _ProductListBottomNavState();
}

class _ProductListBottomNavState extends State<ProductListBottomNav> {
  final CartController cartController = Get.find();
  bool isExpaded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isExpaded ? MediaQuery.of(context).size.height / 1.5 : 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius:
                    isExpaded ? MediaQuery.of(context).size.height / 2 : 2,
                color: Colors.grey.withOpacity(0.5),
                blurRadius:
                    isExpaded ? MediaQuery.of(context).size.height / 2 : 5,
                blurStyle: BlurStyle.normal)
          ]),
      child: InkWell(
        onTap: () {
          if (!isExpaded) {
            isExpaded = !isExpaded;
            setState(() {});
          }
        },
        child: Column(
          children: [
            isExpaded
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          height: 8,
                          width: 40,
                          decoration: BoxDecoration(
                            color: SolhColors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            isExpaded = false;
                            setState(() {});
                          },
                          child: const Icon(
                            CupertinoIcons.clear_thick,
                            color: SolhColors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(child: isExpaded ? itemList() : const SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: [
                SizedBox(
                  child: Row(children: [
                    Text(
                      "${widget.noOfItemsInCart} items",
                      style: GoogleFonts.quicksand(
                          textStyle:
                              SolhTextStyles.CTA.copyWith(color: Colors.black)),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.arrow_drop_up,
                      color: SolhColors.primary_green,
                    )
                  ]),
                ),
                const Spacer(),
                SolhGreenButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.checkoutScreen);
                    },
                    height: 30,
                    width: 100,
                    child: Text(
                      "Next",
                      style: GoogleFonts.quicksand(
                          textStyle: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white)),
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemList() {
    return Obx(() => SizedBox(
          height: MediaQuery.of(context).size.height - 60,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SheetCartItem(
                    isOutOfStock: cartController.cartEntity.value.cartList!
                            .items![index].isOutOfStock ??
                        false,
                    image: cartController.cartEntity.value.cartList!
                            .items![index].productId!.defaultImage ??
                        '',
                    currency: "Rs",
                    discountedPrice: cartController.cartEntity.value.cartList!
                        .items![index].productId!.afterDiscountPrice,
                    itemPrice: cartController.cartEntity.value.cartList!
                        .items![index].productId!.price,
                    inCartNo: cartController
                        .cartEntity.value.cartList!.items![index].quantity,
                    productName: cartController.cartEntity.value.cartList!
                        .items![index].productId!.productName,
                    onIncreaseCartCount: () {
                      if (cartController.cartEntity.value.cartList!
                              .items![index].quantity! ==
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.stockAvailable!) {
                        Utility.showToast("No More Item in Stock");
                        return;
                      }
                      //  Id saved in controller so that we can check on which item we need to show loader//
                      Get.find<AddToCartController>()
                              .indexOfItemToBeUpdated
                              .value =
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!;
                      //////////////

                      widget.onIncreaseCartCount(
                          index,
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!,
                          cartController.cartEntity.value.cartList!
                              .items![index].quantity!);
                    },
                    onDecreaseCartCount: () {
                      //  Id saved in controller so that we can check on which item we need to show loader//
                      Get.find<AddToCartController>()
                              .indexOfItemToBeUpdated
                              .value =
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!;
                      //////////////

                      widget.onDecreaseCartCount(
                          index,
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!,
                          cartController.cartEntity.value.cartList!
                              .items![index].quantity!);
                    },
                    onDeleteItem: () {
                      //  Id saved in controller so that we can check on which item we need to show loader//
                      Get.find<AddToCartController>()
                              .indexOfItemToBeUpdated
                              .value =
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!;
                      //////////////

                      widget.onDecreaseCartCount(
                          index,
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!,
                          1);
                    },
                    id: cartController.cartEntity.value.cartList!.items![index]
                        .productId!.id!);
              },
              separatorBuilder: (_, __) {
                return const Divider(
                  color: Colors.black,
                );
              },
              itemCount:
                  cartController.cartEntity.value.cartList!.items!.length),
        ));
  }
}
