import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'package:readmore/readmore.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/controller/product_detail_controller.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/product_star_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/review_card.dart';
import 'package:solh/widgets_constants/animated_add_to_wishlist_button.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({Key? key, required Map<dynamic, dynamic> args})
      : _id = args['id'],
        super(key: key);

  final String _id;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailController productDetailController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    productDetailController.getProductDetail(widget._id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetProductDeatilAppBar(),
      body: Obx(() {
        return productDetailController.isLoading.value
            ? Center(
                child: MyLoader(),
              )
            : Stack(
                children: [
                  ListView(
                    children: [
                      GetProductStatsAndImage(),
                      GetHelpDivider(),
                      ProductDetails(),
                      GetHelpDivider(),
                      ReviewsSection(),
                      GetHelpDivider(),
                      RelatedProductsSection(),
                      SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AddToCartBuyNowButton(),
                  )
                ],
              );
      }),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  ReviewsSection({super.key});
  ProductDetailController productDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GetHelpCategory(title: 'Cusomer reviews'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductStarWidget(
                  rating: productDetailController
                      .productDetail.value.product!.overAllRating!
                      .toDouble()),
              Text(
                '${productDetailController.productDetail.value.totalReview} global rating',
                style: SolhTextStyles.QS_body_2,
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                itemCount:
                    productDetailController.productDetail.value.reviews!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ReviewCard(
                    imageUrl: productDetailController.productDetail.value
                        .reviews![index].userId!.profilePicture,
                    name: productDetailController
                            .productDetail.value.reviews![index].userId!.name ??
                        '',
                    rating: productDetailController
                        .productDetail.value.reviews![index].rating!
                        .toDouble(),
                    review: productDetailController
                        .productDetail.value.reviews![index].review,
                    reviewedAt: productDetailController
                        .productDetail.value.reviews![index].createdAt,
                  );
                },
              ),
              productDetailController.productDetail.value.reviews!.length < 3
                  ? Container()
                  : Text(
                      'View all 20 reviews ',
                      style: SolhTextStyles.QS_body_2.copyWith(
                          color: SolhColors.primary_green),
                    ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        )
      ],
    );
  }
}

class RelatedProductsSection extends StatelessWidget {
  RelatedProductsSection({super.key});
  ProductDetailController productDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Related products",
          onPressed: () {},
        ),
        SizedBox(
          height: 380,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: productDetailController
                .productDetail.value.product!.relatedProducts!.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              return ProductsCard(
                afterDiscountPrice: productDetailController.productDetail.value
                    .product!.relatedProducts![index].afterDiscountPrice,
                description: productDetailController.productDetail.value
                    .product!.relatedProducts![index].description,
                price: productDetailController
                    .productDetail.value.product!.relatedProducts![index].price,
                productName: productDetailController.productDetail.value
                    .product!.relatedProducts![index].productName,
                productImage: productDetailController.productDetail.value
                    .product!.relatedProducts![index].productImage,
                productQuantity: productDetailController.productDetail.value
                    .product!.relatedProducts![index].productQuantity,
                sId: productDetailController
                    .productDetail.value.product!.relatedProducts![index].sId,
                stockAvailable: productDetailController.productDetail.value
                    .product!.relatedProducts![index].stockAvailable,
              );
            },
          ),
        )
      ],
    );
  }
}

class GetProductStatsAndImage extends StatelessWidget {
  GetProductStatsAndImage({super.key});
  ProductDetailController productDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(productDetailController
                  .productDetail.value.product!.productImage![0]),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            productDetailController.productDetail.value.product!.productName ??
                '',
            style: SolhTextStyles.QS_body_1_med,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    productDetailController
                            .productDetail.value.product!.productQuantity ??
                        '',
                    style: SolhTextStyles.QS_body_2,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow[700],
                      ),
                      Text(
                        productDetailController
                                .productDetail.value.product!.overAllRating
                                .toString() ??
                            '0',
                        style: SolhTextStyles.QS_body_2,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'Available in stock ${productDetailController.productDetail.value.product!.stockAvailable}',
                style: SolhTextStyles.QS_body_2,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                      '${productDetailController.productDetail.value.product!.currency} ${productDetailController.productDetail.value.product!.afterDiscountPrice} ',
                      style: SolhTextStyles.QS_big_body),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'MRP',
                        style: SolhTextStyles.QS_big_body.copyWith(
                            color: SolhColors.grey_2),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${productDetailController.productDetail.value.product!.currency} ${productDetailController.productDetail.value.product!.price} ',
                        style: SolhTextStyles.QS_big_body.copyWith(
                            color: SolhColors.dark_grey,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
              Text(
                '${(100 - (productDetailController.productDetail.value.product!.afterDiscountPrice! / productDetailController.productDetail.value.product!.price!) * 100).toInt()}% OFF',
                style: SolhTextStyles.QS_body_2_semi.copyWith(
                    color: SolhColors.primary_green),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Mfr: Dabar Pharmaceuticals India Pvt Ltd',
                style: SolhTextStyles.QS_caption,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});
  ProductDetailController productDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(title: 'Product Details'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: productDetailController
                .productDetail.value.product!.specification!
                .map((e) => Row(
                      children: [
                        Text(
                          e.label ?? '',
                          style: SolhTextStyles.CTA,
                        ),
                        Text(' : ${e.value}')
                      ],
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ReadMoreText(
              style: SolhTextStyles.QS_body_2,
              lessStyle:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
              moreStyle:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
              parse(productDetailController
                          .productDetail.value.product!.description ??
                      '')
                  .body!
                  .text),
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }
}

class AddToCartBuyNowButton extends StatelessWidget {
  const AddToCartBuyNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26)
      ]),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AddRemoveProductButtoon(),
          SolhGreenMiniButton(
            backgroundColor: SolhColors.primaryRed,
            child: Text(
              'Buy Now',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          )
        ],
      ),
    );
  }
}

class GetProductDeatilAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GetProductDeatilAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: SolhColors.white,
      iconTheme: IconThemeData(color: SolhColors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedAddToWishlistButton(),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 50);
}
