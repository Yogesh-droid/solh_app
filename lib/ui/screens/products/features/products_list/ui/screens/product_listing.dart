import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/products_list_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/empty_list_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/item_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_bottom_nav.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/product_list_shimmer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

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
  final ScrollController scrollController = ScrollController();
  late int pageNo;

  @override
  void initState() {
    pageNo = 1;
    productsListController.getProductList("651d04985cdf213130fb7358", 1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent - 50 &&
          !productsListController.isListEnd) {
        pageNo++;
        productsListController.getProductList(
            "651d04985cdf213130fb7358", pageNo);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(widget.args['itemName'], style: SolhTextStyles.AppBarText),
        isLandingScreen: false,
      ),
      bottomNavigationBar: Obx(() =>
          cartController.cartEntity.value.cartList != null &&
                  cartController.cartEntity.value.cartList!.items!.isNotEmpty
              ? ProductListBottomNav(
                  noOfItemsInCart:
                      cartController.cartEntity.value.cartList!.items!.length,
                  onAddedCart: (index) {
                    onAddedCart(productsListController.productList.indexWhere(
                        (element) =>
                            element.id ==
                            cartController.cartEntity.value.cartList!
                                .items![index].productId!.id));
                  },
                  onDecreaseCartCount: (index) {
                    onDecreaseCartCount(productsListController.productList
                        .indexWhere((element) =>
                            element.id ==
                            cartController.cartEntity.value.cartList!
                                .items![index].productId!.id));
                  },
                  onIncreaseCartCount: (index) {
                    onIncreaseCartCount(productsListController.productList
                        .indexWhere((element) =>
                            element.id ==
                            cartController.cartEntity.value.cartList!
                                .items![index].productId!.id));
                  },
                )
              : SizedBox.shrink()),
      body: Obx(() => productsListController.isLoading.value
          ? productsListController.error.value.isNotEmpty
              ? EmptyListWidget()
              : ProductListShimmer()
          : ListView.separated(
              itemBuilder: (context, index) {
                return ItemWidget(
                  image: productsListController
                      .productList[index].productImage![0],
                  productName:
                      productsListController.productList[index].productName,
                  itemPrice: productsListController.productList[index].price,
                  discountedPrice: productsListController
                      .productList[index].afterDiscountPrice,
                  inCartNo:
                      productsListController.productList[index].inCartCount,
                  isWishListed:
                      productsListController.productList[index].isWishlisted,
                  onAddedCart: () {
                    onAddedCart(index);
                  },
                  onDecreaseCartCount: () async {
                    onDecreaseCartCount(index);
                  },
                  onIncreaseCartCount: () {
                    onIncreaseCartCount(index);
                  },
                );
              },
              separatorBuilder: (_, __) {
                return GetHelpDivider();
              },
              itemCount: productsListController.productList.length)),
    );
  }

  Future<void> onAddedCart(int index) async {
    productsListController.productList[index].inCartCount =
        productsListController.productList[index].inCartCount! + 1;

    productsListController.productList.refresh();

    await addToCartController.addToCart(
        productId: productsListController.productList[index].id!,
        quantity: productsListController.productList[index].inCartCount ?? 0);

    cartController.getCart();
  }

  Future<void> onDecreaseCartCount(int index) async {
    productsListController.productList[index].inCartCount =
        productsListController.productList[index].inCartCount! - 1;

    productsListController.productList.refresh();

    await addToCartController.addToCart(
        productId: productsListController.productList[index].id!,
        quantity: productsListController.productList[index].inCartCount ?? 0);
    await cartController.getCart();
  }

  Future<void> onIncreaseCartCount(int index) async {
    productsListController.productList[index].inCartCount =
        productsListController.productList[index].inCartCount! + 1;
    productsListController.productList.refresh();

    await addToCartController.addToCart(
        productId: productsListController.productList[index].id!,
        quantity: productsListController.productList[index].inCartCount ?? 0);

    await cartController.getCart();
  }
}
