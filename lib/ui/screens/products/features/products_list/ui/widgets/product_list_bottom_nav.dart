import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/sheet_cart_item.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductListBottomNav extends StatefulWidget {
  const ProductListBottomNav(
      {super.key,
      required this.noOfItemsInCart,
      required this.onAddedCart,
      required this.onIncreaseCartCount,
      required this.onDecreaseCartCount});
  final int noOfItemsInCart;
  final Function(int indx) onAddedCart;
  final Function(int index) onIncreaseCartCount;
  final Function(int index) onDecreaseCartCount;

  @override
  State<ProductListBottomNav> createState() => _ProductListBottomNavState();
}

class _ProductListBottomNavState extends State<ProductListBottomNav> {
  final CartController cartController = Get.find();
  bool isExpaded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isExpaded ? MediaQuery.of(context).size.height / 2 : 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            isExpaded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      SizedBox(
                        height: 40,
                        child: Icon(Icons.remove, size: 30, color: Colors.grey),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: SolhColors.grey_2),
                        child: Center(
                          child: IconButton.filled(
                              onPressed: () {
                                isExpaded = false;
                                setState(() {});
                              },
                              icon: Icon(Icons.close,
                                  color: Colors.black, size: 15)),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            Expanded(child: isExpaded ? itemList() : SizedBox()),
            Row(children: [
              SizedBox(
                child: Row(children: [
                  Text(
                    "${widget.noOfItemsInCart} items",
                    style: GoogleFonts.quicksand(
                        textStyle:
                            SolhTextStyles.CTA.copyWith(color: Colors.black)),
                  ),
                  IconButton.filled(
                      onPressed: () {
                        isExpaded = !isExpaded;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.arrow_drop_up,
                        color: SolhColors.primary_green,
                      ))
                ]),
              ),
              Spacer(),
              SolhGreenButton(
                  height: 30,
                  width: 100,
                  child: Text(
                    "Next",
                    style: GoogleFonts.quicksand(
                        textStyle: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white)),
                  ))
            ]),
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
                    image: cartController.cartEntity.value.cartList!
                        .items![index].productId!.productImage![0],
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
                      //  Id saved in controller so that we can check on which item we need to show loader//
                      Get.find<AddToCartController>()
                              .indexOfItemToBeUpdated
                              .value =
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!;
                      //////////////

                      widget.onIncreaseCartCount(index);
                    },
                    onDecreaseCartCount: () {
                      //  Id saved in controller so that we can check on which item we need to show loader//
                      Get.find<AddToCartController>()
                              .indexOfItemToBeUpdated
                              .value =
                          cartController.cartEntity.value.cartList!
                              .items![index].productId!.id!;
                      //////////////

                      widget.onDecreaseCartCount(index);
                    },
                    id: cartController.cartEntity.value.cartList!.items![index]
                        .productId!.id!);
              },
              separatorBuilder: (_, __) {
                return GetHelpDivider();
              },
              itemCount:
                  cartController.cartEntity.value.cartList!.items!.length),
        ));
  }
}
