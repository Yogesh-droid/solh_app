import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/product_wishlist_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/widgets/wishlist_card.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ProductWishlistScreen extends StatefulWidget {
  const ProductWishlistScreen({super.key});

  @override
  State<ProductWishlistScreen> createState() => _ProductWishlistScreenState();
}

class _ProductWishlistScreenState extends State<ProductWishlistScreen>
    with AutomaticKeepAliveClientMixin {
  ProductWishlistController productWishlistController = Get.find();
  AddDeleteWishlistItemController addDeleteWishlistItemController = Get.find();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productWishlistController.getWishlistProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return productWishlistController.isLoading.value ||
              addDeleteWishlistItemController.isLoading.value
          ? Center(
              child: MyLoader(),
            )
          : (productWishlistController.wishlistItems.isEmpty
              ? const EmptyWishListWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () async =>
                        await productWishlistController.getWishlistProducts(),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${productWishlistController.wishlistItems.length} Items in your Wishlist '),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              productWishlistController.wishlistItems.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const GetHelpDivider(),
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
                              stockAvailable: productWishlistController
                                      .wishlistItems[index].stockAvailable ??
                                  0,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ));
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class EmptyWishListWidget extends StatelessWidget {
  const EmptyWishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_wishlist.png',
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Oops! Your Wishlist is Empty',
            style: SolhTextStyles.QS_body_1_bold,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Explore more and shortlist some items',
            style: SolhTextStyles.QS_caption,
          ),
          const SizedBox(
            height: 10,
          ),
          SolhGreenMiniButton(
            onPressed: () => Navigator.of(context).pop(),
            height: 40,
            child: Text(
              'Shop Now',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
