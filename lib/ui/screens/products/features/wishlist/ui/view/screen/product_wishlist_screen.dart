import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/product_wishlist_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/widgets/wishlist_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

class ProductWishlistScreen extends StatefulWidget {
  const ProductWishlistScreen({super.key});

  @override
  State<ProductWishlistScreen> createState() => _ProductWishlistScreenState();
}

class _ProductWishlistScreenState extends State<ProductWishlistScreen> {
  ProductWishlistController productWishlistController = Get.find();
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
      appBar: ProductsAppBar(
        enableWishlist: false,
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Text('6 Items in your Wishlist '),
            ],
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return WishlistCard();
            },
          )
        ],
      ),
    );
  }
}
