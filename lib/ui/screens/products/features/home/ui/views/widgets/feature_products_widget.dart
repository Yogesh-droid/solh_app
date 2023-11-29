import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
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
    this.isInWishlist = false,
    this.inCartItems = 0,
    this.currency,
    required this.onPressed,
  });

  final String? sId;
  final String? productName;
  final List<String>? productImage;
  final int? price;
  final int? afterDiscountPrice;
  final int? stockAvailable;
  final String? description;
  final bool isInWishlist;
  final String? productQuantity;
  final int? inCartItems;
  final String? currency;
  final Function()? onPressed;

  final AddDeleteWishlistItemController addDeleteWishlistItemController =
      Get.find();

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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
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
                  child: AnimatedAddToWishlistButton(
                    isSelected: isInWishlist,
                    onClick: () {
                      addDeleteWishlistItemController
                          .addDeleteWhishlist({"productId": sId});
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    productName ?? '',
                    style: SolhTextStyles.QS_caption_bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Html(data: description, shrinkWrap: true, style: {
                    "body":
                        Style(padding: HtmlPaddings.zero, margin: Margins.zero),
                    "p": Style(
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: FontSize(12),
                    )
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("$currency", style: SolhTextStyles.QS_cap_2),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                            color: SolhColors.greenShade3,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '$currency $afterDiscountPrice',
                          style: SolhTextStyles.QS_caption_bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            AddRemoveProductButtoon(
              productId: sId ?? '',
              productsInCart: inCartItems ?? 0,
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class AddRemoveProductButtoon extends StatefulWidget {
  const AddRemoveProductButtoon(
      {super.key,
      required this.productId,
      required this.productsInCart,
      this.buttonWidth = 100});

  final String productId;
  final int productsInCart;
  final double buttonWidth;

  @override
  State<AddRemoveProductButtoon> createState() =>
      _AddRemoveProductButtoonState();
}

class _AddRemoveProductButtoonState extends State<AddRemoveProductButtoon> {
  CartController cartController = Get.find();

  AddToCartController addToCartController = Get.find();

  late ValueNotifier<int> poductNumber;

  Future<void> onValueChange(int quantity) async {
    await addToCartController.addToCart(
        productId: widget.productId, quantity: quantity);
    await cartController.getCart();
  }

  @override
  void initState() {
    poductNumber = ValueNotifier(widget.productsInCart);

    super.initState();
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
                    SolhGreenButton(
                      height: 35,
                      width: widget.buttonWidth,
                      onPressed: () {
                        poductNumber.value++;
                        onValueChange(poductNumber.value);
                      },
                      child: Text(
                        'Add To Cart',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        poductNumber.value > 0 ? poductNumber.value-- : null;
                        onValueChange(poductNumber.value);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        color: SolhColors.primary_green,
                        child: const Center(
                          child: Icon(Icons.remove, color: SolhColors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: SolhColors.primary_green)),
                      child: Center(
                        child: Text(
                          "$value",
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primary_green),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        poductNumber.value++;
                        onValueChange(poductNumber.value);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        color: SolhColors.primary_green,
                        child: const Center(
                          child: Icon(Icons.add, color: SolhColors.white),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
