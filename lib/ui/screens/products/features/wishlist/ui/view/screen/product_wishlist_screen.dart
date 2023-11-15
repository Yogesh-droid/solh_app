import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/product_wishlist_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/widgets/wishlist_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ProductWishlistScreen extends StatefulWidget {
  const ProductWishlistScreen({super.key});

  @override
  State<ProductWishlistScreen> createState() => _ProductWishlistScreenState();
}

class _ProductWishlistScreenState extends State<ProductWishlistScreen> {
  ProductWishlistController productWishlistController = Get.find();
  AddDeleteWishlistItemController addDeleteWishlistItemController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productWishlistController.getWishlistProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return productWishlistController.isLoading.value ||
                addDeleteWishlistItemController.isLoading.value
            ? Center(
                child: MyLoader(),
              )
            : Scaffold(
                appBar: ProductsAppBar(
                  enableWishlist: false,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Text(
                              '${productWishlistController.wishlistItems.length} Items in your Wishlist '),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        itemCount:
                            productWishlistController.wishlistItems.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => GetHelpDivider(),
                        itemBuilder: (context, index) {
                          return WishlistCard(
                            currency: productWishlistController
                                    .wishlistItems[index].currency ??
                                '',
                            price: productWishlistController
                                .wishlistItems[index].price
                                .toString(),
                            priceAfterDiscount: productWishlistController
                                .wishlistItems[index].afterDiscountPrice
                                .toString(),
                            productImage: productWishlistController
                                .wishlistItems[index].productImage![0],
                            productName: productWishlistController
                                    .wishlistItems[index].productName ??
                                '',
                            productQuantity: productWishlistController
                                    .wishlistItems[index].productQuantity ??
                                '',
                            sId: productWishlistController
                                    .wishlistItems[index].sId ??
                                '',
                            productsInCart: productWishlistController
                                .wishlistItems[index].inCartCount!,
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
