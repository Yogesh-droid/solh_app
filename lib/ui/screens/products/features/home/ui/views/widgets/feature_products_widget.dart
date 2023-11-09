import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/widgets_constants/animated_add_to_wishlist_button.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class FeatureProductsWidget extends StatelessWidget {
  const FeatureProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Products",
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.productsHome);
          },
        ),
        SizedBox(
          height: 380,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              return ProductsCard(
                onPressed: null,
              );
            },
          ),
        )
      ],
    );
  }
}

class ProductsCard extends StatelessWidget {
  ProductsCard({
    super.key,
    this.afterDiscountPrice,
    this.description,
    this.price,
    this.productImage,
    this.productName,
    this.productQuantity,
    this.sId,
    this.stockAvailable,
    required this.onPressed,
  });

  final String? sId;
  final String? productName;
  final List<String>? productImage;
  final int? price;
  final int? afterDiscountPrice;
  final int? stockAvailable;
  final String? description;
  final String? productQuantity;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context)
      //     .pushNamed(AppRoutes.productDetailScreen, arguments: {"id": sId}),
      onTap: onPressed,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: SolhColors.primary_green,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      productImage![0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    )),
                Positioned(
                  right: 10,
                  top: 10,
                  child: AnimatedAddToWishlistButton(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Text(
                    productName ?? '',
                    style: SolhTextStyles.QS_caption_bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Html(data: description, shrinkWrap: true, style: {
                    "p": Style(
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: FontSize(12),
                    )
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("MRP", style: SolhTextStyles.QS_cap_2),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '$price',
                            style: SolhTextStyles.QS_caption.copyWith(
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                            color: SolhColors.primary_green,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '$afterDiscountPrice',
                          style: SolhTextStyles.QS_caption_bold.copyWith(
                              color: SolhColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            AddRemoveProductButtoon(
              productId: sId ?? '',
            )
          ],
        ),
      ),
    );
  }
}

class AddRemoveProductButtoon extends StatelessWidget {
  AddRemoveProductButtoon({
    super.key,
    required this.productId,
  });

  CartController cartController = Get.find();
  AddToCartController addToCartController = Get.find();
  final ValueNotifier<int> poductNumber = ValueNotifier(0);
  final String productId;
  Future<void> onValueChange() async {
    addToCartController.addToCart(
        productId: productId, quantity: poductNumber.value);
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: poductNumber,
        builder: (context, value, child) {
          return value == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SolhGreenMiniButton(
                      onPressed: () => poductNumber.value++,
                      child: Text(
                        'Add To Cart',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => poductNumber.value > 0
                            ? poductNumber.value--
                            : null,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: SolhColors.primary_green,
                          child: Center(
                            child: Icon(Icons.remove, color: SolhColors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: SolhColors.primary_green)),
                        child: Center(
                            child: Text(
                          "$value",
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primary_green),
                        )),
                      ),
                      GestureDetector(
                        onTap: () => poductNumber.value++,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: SolhColors.primary_green,
                          child: Center(
                            child: Icon(Icons.add, color: SolhColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
