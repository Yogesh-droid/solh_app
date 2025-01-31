import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/controller/product_detail_controller.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/product_detail_bottom_nav.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/product_star_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/review_card.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/product_list_model.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/controller/add_delete_wishlist_item_controller.dart';
import 'package:solh/widgets_constants/animated_add_to_wishlist_button.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/zoom_image.dart';

import '../../../../products_list/ui/controllers/products_list_controller.dart';
import '../../../../products_list/ui/widgets/cart_count_btn.dart';
import '../widgets/deactivated_cart_btn.dart';

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
  CartController cartController = Get.find();
  ProductDetailsModel? productDetailsModel;
  bool isLoading = true;

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
        // appBar: const GetProductDeatilAppBar(),
        appBar: SolhAppBar(
            isLandingScreen: false,
            isVideoCallScreen: true,
            title: const Text("Details", style: SolhTextStyles.QS_body_1_bold)),
        bottomNavigationBar: Obx(
            () => cartController.cartEntity.value.cartList!.items!.isNotEmpty
                ? ProductDetailBottomNav(onNextPressed: () {
                    onNextPressed();
                  })
                : const SizedBox()),
        body: isLoading
            ? Center(
                child: MyLoader(),
              )
            : Stack(
                children: [
                  ListView(
                    children: [
                      GetProductStatsAndImage(
                          productDetailsModel: productDetailsModel!,
                          id: widget._id),
                      const GetHelpDivider(),
                      ProductDetails(productDetailsModel: productDetailsModel!),
                      const GetHelpDivider(),
                      ReviewsSection(productDetailsModel: productDetailsModel!),
                      const GetHelpDivider(),
                      RelatedProductsSection(
                          productDetailsModel: productDetailsModel!),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                  /*  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AddToCartBuyNowButton(
                        productId: productDetailsModel.product!.sId ?? ''),
                  ) */
                ],
              ));
  }

  Future<void> getProductDetails() async {
    await productDetailController.getProductDetail(widget._id);
    productDetailsModel = productDetailController.productDetail.value;
    isLoading = false;
    setState(() {});
  }

  onNextPressed() {
    Navigator.pushNamed(context, AppRoutes.checkoutScreen);
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
                height: 300,
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
                      shortDescription: productDetailsModel
                          .product!.relatedProducts![index].shortDescription,
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
  GetProductStatsAndImage(
      {super.key, required this.productDetailsModel, required this.id});
  final ProductDetailController productDetailController = Get.find();
  final ProductDetailsModel productDetailsModel;
  final AddToCartController addToCartController = Get.find();
  final CartController cartController = Get.find();
  final String id;

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
                    getStockString(
                        productDetailsModel.product!.stockAvailable ?? 0),
                    style: SolhTextStyles.QS_body_2.copyWith(
                        color: SolhColors.primaryRed),
                  ),
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
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Html(
                        data: productDetailsModel.product!.shortDescription ??
                            productDetailsModel.product!.description,
                        shrinkWrap: true,
                        style: {
                          "body": Style(
                              padding: HtmlPaddings.zero, margin: Margins.zero),
                          "p": Style(
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: FontSize(12),
                          )
                        }),
                  ),
                  const Spacer(),
                  Expanded(
                      flex: 1,
                      child: Obx(() => cartController.isCartLoading.value ||
                              addToCartController.addingToCart.value
                          ? const DeactivatedCartBtn()
                          : productDetailController.productDetail.value.product!
                                      .inCartCount! >
                                  0
                              ? CartCountBtn(
                                  decreaseCartCount: () =>
                                      onChangeCartCount(false),
                                  increaseCartCount: () =>
                                      onChangeCartCount(true),
                                  itemInCart: productDetailController
                                          .productDetail
                                          .value
                                          .product!
                                          .inCartCount ??
                                      0)
                              : SolhGreenButton(
                                  height: 30,
                                  width: 50,
                                  onPressed: () => onChangeCartCount(true),
                                  child: Text(
                                    'Add',
                                    style: GoogleFonts.quicksand(
                                        textStyle: SolhTextStyles.CTA,
                                        color: SolhColors.white),
                                  ))))
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

  onChangeCartCount(bool isIncrease) async {
    final List<Products> products =
        Get.find<ProductsListController>().productList;
    if (isIncrease &&
        productDetailController.productDetail.value.product!.stockAvailable! <=
            productDetailController.productDetail.value.product!.inCartCount!) {
      Utility.showToast("Quantity more than stock cannot be added");
      return;
    }
    if (products.isNotEmpty) {
      for (var element in products) {
        if (element.id == id) {
          element.inCartCount =
              isIncrease ? element.inCartCount! + 1 : element.inCartCount! - 1;
          Get.find<ProductsListController>().productList.refresh();
        }
      }
    }

    await addToCartController
        .addToCart(
            productId: productDetailsModel.product!.sId ?? '',
            quantity: isIncrease
                ? productDetailController
                        .productDetail.value.product!.inCartCount! +
                    1
                : productDetailController
                        .productDetail.value.product!.inCartCount! -
                    1)
        .then((value) => cartController.getCart());
    productDetailController.productDetail.value.product!.inCartCount =
        isIncrease
            ? productDetailController
                    .productDetail.value.product!.inCartCount! +
                1
            : productDetailController
                    .productDetail.value.product!.inCartCount! -
                1;
    productDetailController.productDetail.refresh();
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
                          "${e.label ?? ''} :",
                          style: SolhTextStyles.CTA,
                        ),
                        Text('  ${e.value}')
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            color: SolhColors.grey239,
                            child: CachedNetworkImage(
                              imageUrl: e,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    "assets/icons/app-bar/no-image.png");
                              },
                              placeholder: (context, url) {
                                return Image.asset(
                                    "assets/images/opening_link.gif");
                              },
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                '${(100 - (widget.productDetailsModel.product!.afterDiscountPrice! / widget.productDetailsModel.product!.price!) * 100).toInt()}%',
                                                style: SolhTextStyles
                                                        .QS_cap_2_semi
                                                    .copyWith(
                                                        color:
                                                            SolhColors.white),
                                              ),
                                              Text(
                                                'OFF',
                                                style: SolhTextStyles
                                                        .QS_cap_2_semi
                                                    .copyWith(
                                                        color:
                                                            SolhColors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: AnimatedAddToWishlistButton(
                                    isSelected: widget.productDetailsModel
                                            .product!.isWishlisted ??
                                        false,
                                    onClick: () async {
                                      await Get.find<
                                              AddDeleteWishlistItemController>()
                                          .addDeleteWhishlist({
                                        "productId": widget
                                            .productDetailsModel.product!.sId
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
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

String getStockString(int itemInStock) {
  if (itemInStock == 0) {
    return ' Out of stock';
  } else if (itemInStock <= 15) {
    return ' $itemInStock left';
  }
  return 'In stock';
}
