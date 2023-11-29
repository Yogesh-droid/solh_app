import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/controller/product_detail_controller.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/product_star_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/review_card.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/product_wishlist_controller.dart';
import 'package:solh/widgets_constants/animated_add_to_wishlist_button.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/zoom_image.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({required Map<dynamic, dynamic> args})
      : _id = args['id'],
        super(key: args['key']);

  final String _id;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailController productDetailController = Get.find();
  late ProductDetailsModel productDetailsModel;
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProductDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.key,
        appBar: GetProductDeatilAppBar(),
        body: isLoading
            ? Center(
                child: MyLoader(),
              )
            : Stack(
                children: [
                  ListView(
                    children: [
                      GetProductStatsAndImage(
                          productDetailsModel: productDetailsModel),
                      const GetHelpDivider(),
                      ProductDetails(productDetailsModel: productDetailsModel),
                      const GetHelpDivider(),
                      ReviewsSection(productDetailsModel: productDetailsModel),
                      const GetHelpDivider(),
                      RelatedProductsSection(
                          productDetailsModel: productDetailsModel),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AddToCartBuyNowButton(
                        productId: productDetailsModel.product!.sId ?? ''),
                  )
                ],
              ));
  }

  Future<void> getProductDetails() async {
    isLoading = true;
    setState(() {});
    await productDetailController.getProductDetail(widget._id);
    productDetailsModel = productDetailController.productDetail.value;
    isLoading = false;
    setState(() {});
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.productDetailsModel});
  final ProductDetailsModel productDetailsModel;
  @override
  Widget build(BuildContext context) {
    return productDetailsModel.product!.overAllRating! < 1
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GetHelpCategory(title: 'Customer Reviews'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductStarWidget(
                        rating: productDetailsModel.product!.overAllRating!
                            .toDouble()),
                    Text(
                      '${productDetailsModel.totalReview} global rating',
                      style: SolhTextStyles.QS_body_2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      itemCount: productDetailsModel.reviews!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ReviewCard(
                          imageUrl: productDetailsModel
                              .reviews![index].userId!.profilePicture,
                          name: productDetailsModel
                                  .reviews![index].userId!.name ??
                              '',
                          rating: productDetailsModel.reviews![index].rating!
                              .toDouble(),
                          review: productDetailsModel.reviews![index].review,
                          reviewedAt:
                              productDetailsModel.reviews![index].createdAt,
                        );
                      },
                    ),
                    productDetailsModel.reviews!.length < 3
                        ? Container()
                        : Text(
                            'View all 20 reviews ',
                            style: SolhTextStyles.QS_body_2.copyWith(
                                color: SolhColors.primary_green),
                          ),
                    const SizedBox(
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
  const RelatedProductsSection({super.key, required this.productDetailsModel});
  final ProductDetailsModel productDetailsModel;
  @override
  Widget build(BuildContext context) {
    return productDetailsModel.product!.relatedProducts!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              GetHelpCategory(
                title: "Related Products",
                // onPressed: () {},
              ),
              SizedBox(
                height: 380,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount:
                      productDetailsModel.product!.relatedProducts!.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ProductsCard(
                      afterDiscountPrice: productDetailsModel
                          .product!.relatedProducts![index].afterDiscountPrice,
                      description: productDetailsModel
                          .product!.relatedProducts![index].description,
                      price: productDetailsModel
                          .product!.relatedProducts![index].price,
                      productName: productDetailsModel
                          .product!.relatedProducts![index].productName,
                      productImage: productDetailsModel
                          .product!.relatedProducts![index].productImage,
                      productQuantity: productDetailsModel
                          .product!.relatedProducts![index].productQuantity,
                      sId: productDetailsModel
                          .product!.relatedProducts![index].sId,
                      stockAvailable: productDetailsModel
                          .product!.relatedProducts![index].stockAvailable,
                      inCartItems: productDetailsModel
                          .product!.relatedProducts![index].inCartCount,
                      isInWishlist: productDetailsModel
                              .product!.relatedProducts![index].isWishlisted ??

                          false,
                      currency: productDetailsModel
                          .product!.relatedProducts![index].currency,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            AppRoutes.productDetailScreen,
                            arguments: {
                              "id": productDetailsModel
                                  .product!.relatedProducts![index].sId,
                              'key': ObjectKey(
                                  "${productDetailsModel.product!.relatedProducts![index].sId}")
                            });
                      },
                    );
                  },
                ),
              )
            ],
          );
  }
}

class GetProductStatsAndImage extends StatelessWidget {
  const GetProductStatsAndImage({super.key, required this.productDetailsModel});
  // final ProductDetailController productDetailController = Get.find();
  final ProductDetailsModel productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetProductImages(productDetailsModel: productDetailsModel)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productDetailsModel.product!.productName ?? '',
                style: SolhTextStyles.QS_body_1_med,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        productDetailsModel.product!.productQuantity ?? '',
                        style: SolhTextStyles.QS_body_2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (productDetailsModel.product!.overAllRating! > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.yellow[700],
                            ),
                            Text(
                              productDetailsModel.product!.overAllRating
                                  .toString(),
                              style: SolhTextStyles.QS_body_2,
                            ),
                          ],
                        )
                    ],
                  ),
                  Text(
                    'Available in stock ${productDetailsModel.product!.stockAvailable}',
                    style: SolhTextStyles.QS_body_2,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                          '${productDetailsModel.product!.currency} ${productDetailsModel.product!.afterDiscountPrice} ',
                          style: SolhTextStyles.QS_big_body),
                      const SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            '${productDetailsModel.product!.currency} ${productDetailsModel.product!.price} ',
                            style: SolhTextStyles.QS_big_body.copyWith(
                                color: SolhColors.grey,
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    '${(100 - (productDetailsModel.product!.afterDiscountPrice! / productDetailsModel.product!.price!) * 100).toInt()}% OFF',
                    style: SolhTextStyles.QS_body_2_semi.copyWith(
                        color: SolhColors.primary_green),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    productDetailsModel.product!.skuOrIsbn ?? '',
                    style: SolhTextStyles.QS_caption,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productDetailsModel});
  final ProductDetailsModel productDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(title: 'Product Details'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: productDetailsModel.product!.specification!
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
              parse(productDetailsModel.product!.description ?? '').body!.text),
        ),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}

class AddToCartBuyNowButton extends StatelessWidget {
  AddToCartBuyNowButton({super.key, required this.productId});
  final String productId;

  final ProductDetailController productDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26)
          ]),
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AddRemoveProductButtoon(
            productId: productId,
            productsInCart: productDetailController
                    .productDetail.value.product!.inCartCount ??
                0,
            buttonWidth: 200,
          ),
          // SolhGreenMiniButton(
          //   backgroundColor: SolhColors.primaryRed,
          //   child: Text(
          //     'Buy Now',
          //     style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
          //   ),
          // )
        ],
      ),
    );
  }
}

class GetProductImages extends StatefulWidget {
  const GetProductImages({
    super.key,
    required this.productDetailsModel,
  });

  final ProductDetailsModel productDetailsModel;

  @override
  State<GetProductImages> createState() => _GetProductImagesState();
}

class _GetProductImagesState extends State<GetProductImages> {
  PageController pageController = PageController();
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: 100.w,
          child: PageView(
            onPageChanged: (value) {
              imageIndex = value;
              setState(() {});
            },
            controller: pageController,
            children: widget.productDetailsModel.product!.productImage!
                .map(
                  (e) => GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ZoomImage(image: e),
                    )),
                    child: Image.network(e),
                  ),
                )
                .toList(),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.productDetailsModel.product!.productImage!
                .map((e) => Container(
                      margin: const EdgeInsets.all(3),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: imageIndex ==
                                widget
                                    .productDetailsModel.product!.productImage!
                                    .indexOf(e)
                            ? SolhColors.grey
                            : SolhColors.grey_3,
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class GetProductDeatilAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  GetProductDeatilAppBar({super.key});
  final ProductDetailController productDetailController = Get.find();
  final AddDeleteWishlistItemController addDeleteWishlistItemController =
      Get.find();
  final ProductWishlistController productWishlistController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.back,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: SolhColors.white,
      iconTheme: const IconThemeData(color: SolhColors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Obx(() {
            return AnimatedAddToWishlistButton(
              onClick: () async {
                await addDeleteWishlistItemController.addDeleteWhishlist({
                  "productId":
                      productDetailController.productDetail.value.product!.sId
                });

                await productWishlistController.getWishlistProducts();
              },
              isSelected: productDetailController
                      .productDetail.value.product!.isWishlisted ??
                  false,
            );
          }),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(0, 50);
}
