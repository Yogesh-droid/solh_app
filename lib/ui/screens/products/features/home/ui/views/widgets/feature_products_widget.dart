import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/feature_products_controller.dart';
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
    this.shortDescription,
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
  final String? shortDescription;
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
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                    height: 180,
                  ),
                ),
                Positioned(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/images/discount_bg.svg',
                              height: 40,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${(100 - (afterDiscountPrice! / price!) * 100).toInt()}%',
                                      style:
                                          SolhTextStyles.QS_cap_2_semi.copyWith(
                                              color: SolhColors.white),
                                    ),
                                    Text(
                                      'OFF',
                                      style:
                                          SolhTextStyles.QS_cap_2_semi.copyWith(
                                              color: SolhColors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AnimatedAddToWishlistButton(
                          isSelected: isInWishlist,
                          onClick: () async {
                            await addDeleteWishlistItemController
                                .addDeleteWhishlist({"productId": sId});
                            // await Get.find<FeatureProductsController>()
                            //     .getFeatureProducts();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productName ?? '',
                      style: SolhTextStyles.QS_caption_bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    shortDescription != null
                        ? Html(
                            data: shortDescription,
                            style: {
                              "body": Style(
                                  padding: HtmlPaddings.zero,
                                  margin: Margins.zero,
                                  fontSize: FontSize(12)),
                            },
                          )
                        : Container(),
                    // Html(data: description, shrinkWrap: true, style: {
                    //   "body":
                    //       Style(padding: HtmlPaddings.zero, margin: Margins.zero),
                    //   "p": Style(
                    //     maxLines: 3,
                    //     textOverflow: TextOverflow.ellipsis,
                    //     fontSize: FontSize(12),
                    //   )
                    // }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("$currency",
                                    style: SolhTextStyles.QS_cap_2),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '$price',
                                  style: SolhTextStyles.QS_caption.copyWith(
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 8, vertical: 4),
                            //   decoration: BoxDecoration(
                            //       color: SolhColors.greenShade3,
                            //       borderRadius: BorderRadius.circular(8)),
                            //   child: Row(
                            //     children: [
                            //       const Icon(
                            //         CupertinoIcons.bolt_fill,
                            //         color: SolhColors.greenShade1,
                            //         size: 12,
                            //       ),
                            //       Text(
                            //         '${(100 - (afterDiscountPrice! / price!) * 100).toInt()}% OFF',
                            //         style:
                            //             SolhTextStyles.QS_caption_2_bold.copyWith(
                            //                 color: SolhColors.greenShade1),
                            //       )
                            //     ],
                            //   ),
                            //)
                          ],
                        ),
                        AddRemoveProductButtoon(
                          buttonTitle: 'Add',
                          buttonWidth: 50,
                          productId: sId ?? '',
                          productsInCart: inCartItems ?? 0,
                          isEnabled: stockAvailable != 0,
                          stockLimit: stockAvailable,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
      this.buttonWidth = 100,
      this.isEnabled,
      this.stockLimit,
      this.buttonTitle = 'Add To Cart'});

  final String productId;
  final String buttonTitle;
  final int productsInCart;
  final double buttonWidth;
  final bool? isEnabled;
  final int? stockLimit;

  @override
  State<AddRemoveProductButtoon> createState() =>
      _AddRemoveProductButtoonState();
}

class _AddRemoveProductButtoonState extends State<AddRemoveProductButtoon> {
  CartController cartController = Get.find();

  AddToCartController addToCartController = Get.find();

  late ValueNotifier<int> poductNumber;

  Future<void> onValueChange(int quantity) async {
    await addToCartController
        .addToCart(productId: widget.productId, quantity: quantity)
        .then((value) => cartController.getCart());
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
                    widget.isEnabled == false
                        ? SolhGreenButton(
                            width: widget.buttonWidth,
                            height: 35,
                            backgroundColor: SolhColors.grey,
                            child: Text(
                              widget.buttonTitle,
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.white),
                            ),
                          )
                        : SolhGreenButton(
                            height: 35,
                            width: widget.buttonWidth,
                            onPressed: () {
                              poductNumber.value++;
                              onValueChange(poductNumber.value);
                            },
                            child: Text(
                              widget.buttonTitle,
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
                      width: 40,
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
                        if (widget.stockLimit != null &&
                            poductNumber.value < widget.stockLimit!.toInt()) {
                          poductNumber.value++;
                        }
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
