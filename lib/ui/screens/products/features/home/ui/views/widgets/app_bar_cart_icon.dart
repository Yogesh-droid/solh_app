import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/controller/product_detail_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/product_list_model.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/products_list_controller.dart';

import '../../../../../../../../routes/routes.dart';
import '../../../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../../../widgets_constants/constants/textstyles.dart';
import '../../../../cart/ui/controllers/add_to_cart_controller.dart';
import '../../../../cart/ui/controllers/cart_controller.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.itemsInCart, this.id});

  final int itemsInCart;
  final String? id;
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
          ///updating List of Products
          ///
          if (id != null) {
            final List<Products> products =
                Get.find<ProductsListController>().productList;
            if (products.isNotEmpty) {
              for (var element in products) {
                if (element.id == id) {
                  element.inCartCount = element.inCartCount! - 1;
                  Get.find<ProductsListController>().productList.refresh();
                }
              }
            }
            // updating product detail page
            final ProductDetailsModel productDetailsModel =
                Get.find<ProductDetailController>().productDetail.value;
            if (productDetailsModel.product!.sId == id) {
              productDetailsModel.product!.inCartCount =
                  productDetailsModel.product!.inCartCount! - 1;
              Get.find<ProductDetailController>().productDetail.refresh();
            }
          }

          ///
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
          ///
          if (id != null) {
            final List<Products> products =
                Get.find<ProductsListController>().productList;
            if (products.isNotEmpty) {
              for (var element in products) {
                if (element.id == id) {
                  element.inCartCount = element.inCartCount! + 1;
                  Get.find<ProductsListController>().productList.refresh();
                }
              }
            }
            // updating product detail page
            final ProductDetailsModel productDetailsModel =
                Get.find<ProductDetailController>().productDetail.value;
            if (productDetailsModel.product!.sId == id) {
              productDetailsModel.product!.inCartCount =
                  productDetailsModel.product!.inCartCount! + 1;
              Get.find<ProductDetailController>().productDetail.refresh();
            }
          }

          ///
          ///
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
              if (itemsInCart > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: SolhColors.primary_green),
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
