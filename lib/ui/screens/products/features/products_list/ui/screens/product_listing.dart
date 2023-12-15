import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/product_sub_cat_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/products_list_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/empty_list_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/item_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_bottom_nav.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_sub_cat_widget.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../../../../routes/routes.dart';

class ProductLisingPage extends StatefulWidget {
  const ProductLisingPage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<ProductLisingPage> createState() => _ProductLisingPageState();
}

class _ProductLisingPageState extends State<ProductLisingPage> {
  final ProductsListController productsListController = Get.find();
  final CartController cartController = Get.find();
  final AddToCartController addToCartController = Get.find();
  final AddDeleteWishlistItemController addDeleteWishlistItemController =
      Get.find();
  final ProductSubCatController productSubCatController = Get.find();
  final ScrollController scrollController = ScrollController();
  late int pageNo;

  @override
  void initState() {
    // To make subcategory reset to ALL make it's id -1
    productsListController.selectedSubCat.value = "-1";
    productsListController.selectedSubCatName.value = "All";
    productsListController.query = "";

    //
    if (widget.args['subCat'] != null) {
      productsListController.query = "&subcategory=${widget.args['subCat']}";
    }
    pageNo = 1;
    productsListController.getProductList(widget.args['id'] ?? '', 1);
    productSubCatController.getProductSubCat(widget.args['id'] ?? '');

    scrollController.addListener(() {
      if (!productsListController.isLoadingMore.value &&
          !productsListController.isListEnd) {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        double delta = 200.0;

        if (maxScroll - currentScroll <= delta) {
          pageNo++;
          productsListController.getProductList(
              widget.args['id'] ?? '', pageNo);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isVideoCallScreen: true,
        title: Obx(() => SizedBox(
              width: 220,
              child: Text(
                  "${widget.args['itemName']} - ${productsListController.selectedSubCatName.value}",
                  style: SolhTextStyles.AppBarText),
            )),
        isLandingScreen: false,
      ),
      bottomNavigationBar: Obx(() => cartController.cartEntity.value.cartList !=
                  null &&
              cartController.cartEntity.value.cartList!.items!.isNotEmpty
          ? ProductListBottomNav(
              noOfItemsInCart:
                  cartController.cartEntity.value.cartList!.items!.length,
              onDecreaseCartCount: (index, id, quantity) {
                onDecreaseCartCount(
                    productsListController.productList.indexWhere((element) =>
                        element.id ==
                        cartController.cartEntity.value.cartList!.items![index]
                            .productId!.id),
                    id,
                    quantity);
              },
              onIncreaseCartCount: (index, id, quantity) {
                onIncreaseCartCount(
                    productsListController.productList.indexWhere((element) =>
                        element.id ==
                        cartController.cartEntity.value.cartList!.items![index]
                            .productId!.id),
                    id,
                    quantity,
                    0);
              },
            )
          : const SizedBox.shrink()),
      body: ListView(
        controller: scrollController,
        children: [
          if (widget.args['id'] != null)
            ProductSubCatWidget(
                catId: widget.args['id'], img: widget.args['img']),
          Obx(
            () => productsListController.isLoading.value
                ? productsListController.error.value.isNotEmpty
                    ? const EmptyListWidget()
                    : const ProductListShimmer()
                : productsListController.productList.isEmpty
                    ? const EmptyListWidget()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.productDetailScreen,
                                  arguments: {
                                    "id": productsListController
                                        .productList[index].id,
                                    "onDecrease": (index, id, quantity) {
                                      onDecreaseCartCount(
                                          productsListController.productList
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  cartController
                                                      .cartEntity
                                                      .value
                                                      .cartList!
                                                      .items![index]
                                                      .productId!
                                                      .id),
                                          id,
                                          quantity);
                                    },
                                    "onIncrease": (index, id, quantity) {
                                      onIncreaseCartCount(
                                          productsListController.productList
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  cartController
                                                      .cartEntity
                                                      .value
                                                      .cartList!
                                                      .items![index]
                                                      .productId!
                                                      .id),
                                          id,
                                          quantity,
                                          0);
                                    },
                                  });
                            },
                            child: ItemWidget(
                              image: productsListController
                                      .productList[index].defaultImage ??
                                  '',
                              stock: productsListController
                                  .productList[index].stockAvailable,
                              currency: productsListController
                                  .productList[index].currency,
                              descrition: productsListController
                                      .productList[index].shortDescription ??
                                  productsListController
                                      .productList[index].description,
                              productName: productsListController
                                  .productList[index].productName,
                              itemPrice: productsListController
                                  .productList[index].price,
                              discountedPrice: productsListController
                                  .productList[index].afterDiscountPrice,
                              inCartNo: productsListController
                                  .productList[index].inCartCount,
                              isWishListed: productsListController
                                  .productList[index].isWishlisted,
                              onAddedCart: () {
                                onAddedCart(index);
                              },
                              onDecreaseCartCount: () async {
                                onDecreaseCartCount(
                                    index,
                                    productsListController
                                        .productList[index].id!,
                                    productsListController
                                        .productList[index].inCartCount!);
                              },
                              onIncreaseCartCount: () {
                                onIncreaseCartCount(
                                    index,
                                    productsListController
                                        .productList[index].id!,
                                    productsListController
                                        .productList[index].inCartCount!,
                                    productsListController
                                        .productList[index].stockAvailable!);
                              },
                              onWishlisted: () async {
                                await addDeleteWishlistItemController
                                    .addDeleteWhishlist({
                                  "productId": productsListController
                                      .productList[index].id!
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const GetHelpDivider();
                        },
                        itemCount: productsListController.productList.length),
          ),
          Obx(() => productsListController.isLoadingMore.value
              ? MyLoader()
              : const SizedBox.shrink())
        ],
      ),
    );
  }

// To add item to cart

  Future<void> onAddedCart(int index) async {
    productsListController.productList[index].inCartCount =
        productsListController.productList[index].inCartCount! + 1;

    productsListController.productList.refresh();

    await addToCartController.addToCart(
        productId: productsListController.productList[index].id!,
        quantity: productsListController.productList[index].inCartCount ?? 0);

    cartController.getCart();
  }

// To decrease item's quantity

  Future<void> onDecreaseCartCount(int index, String id, int quantity) async {
    if (index >= 0) {
      if (quantity > 1) {
        productsListController.productList[index].inCartCount =
            productsListController.productList[index].inCartCount! - 1;
      } else {
        productsListController.productList[index].inCartCount = 0;
      }

      productsListController.productList.refresh();
    }
    await addToCartController.addToCart(productId: id, quantity: quantity - 1);
    await cartController.getCart();
  }

// to increase item's quantity

  Future<void> onIncreaseCartCount(
      int index, String id, int quantity, int? stock) async {
    if (quantity == stock) {
      Utility.showToast("No More Item in Stock");
      return;
    }
    await addToCartController.addToCart(productId: id, quantity: quantity + 1);
    if (addToCartController.error.value.isEmpty) {
      if (index >= 0) {
        productsListController.productList[index].inCartCount =
            productsListController.productList[index].inCartCount! + 1;
        productsListController.productList.refresh();
      }
      await cartController.getCart();
    } else {
      Utility.showToast(addToCartController.error.value);
    }
  }
}
