import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/add_to_cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/feature_products_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/product_cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/product_category_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/product_mainCat_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/controllers/products_home_carousel_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/in_cart_product_item_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../../../my-profile/my-profile-screenV2/my_profile_screenV2.dart';
import '../../../../products_list/ui/widgets/product_list_bottom_nav.dart';

class ProductsHome extends StatefulWidget {
  const ProductsHome({super.key});

  @override
  State<ProductsHome> createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  ProductMainCatController productMainCatController = Get.find();
  ProductsCategoryController productsCategoryController = Get.find();
  FeatureProductsController featureProductsController = Get.find();
  ProductsHomeCarouselController productsHomeCarouselController = Get.find();
  final AddToCartController addToCartController = Get.find();
  final CartController cartController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productMainCatController.getMainCat();
      productsCategoryController.getProductsCategories();
      featureProductsController.getFeatureProducts();
      productsHomeCarouselController.getBanners();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ProductsAppBar(
          title: getDrawer(),
          popupMenu: getMorePopMenu(),
        ),
        bottomNavigationBar: Obx(() =>
            cartController.cartEntity.value.cartList != null &&
                    cartController.cartEntity.value.cartList!.items!.isNotEmpty
                ? ProductListBottomNav(
                    noOfItemsInCart:
                        cartController.cartEntity.value.cartList!.items!.length,
                    onDecreaseCartCount: (index, id, quantity) async {
                      await addToCartController.addToCart(
                          productId: id, quantity: quantity - 1);
                      await cartController.getCart();
                    },
                    onIncreaseCartCount: (index, id, quantity) async {
                      await addToCartController.addToCart(
                          productId: id, quantity: quantity + 1);
                      await cartController.getCart();
                    },
                  )
                : const SizedBox.shrink()),
        body: Stack(
          children: [
            Obx(() => ListView(
                  children: [
                    // const ProductsSearchBar(),
                    // const GetHelpDivider(),
                    ProductsCategories(),
                    const GetHelpDivider(),
                    if (productsHomeCarouselController
                        .homeCarouselBanners.isNotEmpty)
                      const ProductsBannerCarousel(),
                    if (productsHomeCarouselController
                        .homeCarouselBanners.isNotEmpty)
                      const GetHelpDivider(),
                    // ProductsSearchCategories(),
                    // const GetHelpDivider(),
                    FeatureProductsSection(),
                    const GetHelpDivider(),
                    // YouMightFindHelpfulSection(),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                )),
            //Positioned(bottom: 0, left: 0, right: 0, child: NextBottomBar())
          ],
        ));
  }

  Widget getDrawer() {
    final ProfileController profileController = Get.find();
    return Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyProfileScreenV2()));
          },
          child: Obx(() {
            return profileController.isProfileLoading.value
                ? Center(
                    child: SizedBox(
                        height: 15, width: 15, child: MyLoader(strokeWidth: 2)),
                  )
                : profileController.myProfileModel.value.body == null
                    ? InkWell(
                        onTap: () {
                          profileController.getMyProfile();
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          // height: 30,
                          // width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: SolhColors.primary_green),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: SolhColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 4.8.w,
                          backgroundColor: SolhColors.primary_green,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 4.5.w,
                            backgroundImage: CachedNetworkImageProvider(
                              profileController.myProfileModel.value.body!.user!
                                      .profilePicture ??
                                  "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                            ),
                          ),
                        ),
                      );
          }),
        ));
  }

  Widget getMorePopMenu() {
    return PopupMenuButton(
        child: const Icon(Icons.more_vert, color: SolhColors.primary_green),
        itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text("My Orders"),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.orderListScreen),
              )
            ]);
  }
}

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: SearchBar(
        hintText: "Search for Mental wellness Products",
        hintStyle: MaterialStateProperty.resolveWith(
            (states) => const TextStyle(color: SolhColors.Grey_1)),
        trailing: const [
          Icon(
            Icons.search,
            color: SolhColors.primary_green,
          )
        ],
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
      ),
    );
  }
}

class ProductsCategories extends StatelessWidget {
  ProductsCategories({super.key});
  final ProductMainCatController productMainCatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return productMainCatController.isLoading.value
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonLoadingAnimation(
                  ballColor: SolhColors.primary_green,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Categories",
                    style: SolhTextStyles.QS_body_semi_1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: productMainCatController.mainCatList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.productList,
                                arguments: {
                                  "itemName": productMainCatController
                                      .mainCatList[index].categoryName,
                                  "id": productMainCatController
                                      .mainCatList[index].id,
                                  "img": productMainCatController
                                      .mainCatList[index].categoryImage,
                                });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(25),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: SolhColors.Tertiary_Red,
                                ),
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.network(productMainCatController
                                      .mainCatList[index].categoryImage!),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                productMainCatController
                                    .mainCatList[index].categoryName!,
                                style: SolhTextStyles.QS_caption,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
    });
  }
}

class ProductsBannerCarousel extends StatefulWidget {
  const ProductsBannerCarousel({super.key});

  @override
  State<ProductsBannerCarousel> createState() => _ProductsBannerCarouselState();
}

class _ProductsBannerCarouselState extends State<ProductsBannerCarousel> {
  final CarouselController buttonCarouselController = CarouselController();
  ProductsHomeCarouselController productsHomeCarouselController = Get.find();
  int pageIndex = 0;

  final List imageArray = [
    "https://picsum.photos/300/200?grayscale",
    "https://picsum.photos/seed/picsum/300/200",
    "https://picsum.photos/300/200?grayscale",
    "https://picsum.photos/seed/picsum/300/200"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          CarouselSlider(
            items: productsHomeCarouselController.homeCarouselBanners
                .map(
                  (e) => InkWell(
                    onTap: () {
                      if (e.routeName == "productcategory") {
                        Navigator.pushNamed(context, AppRoutes.productList,
                            arguments: {
                              "itemName": e.bannerName,
                              "id": e.routeKey,
                              "img": e.bannerImage
                            });
                      }
                      if (e.routeName == "product") {
                        Navigator.of(context).pushNamed(
                            AppRoutes.productDetailScreen,
                            arguments: {
                              "id": e.routeKey,
                            });
                      }
                      if (e.routeName == "subcategory") {
                        Navigator.pushNamed(context, AppRoutes.productList,
                            arguments: {
                              "itemName": e.bannerName,
                              "subCat": e.routeKey
                            });
                      }
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(e.bannerImage ?? '')),
                  ),
                )
                .toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                pageIndex = index;
                setState(() {});
              },
              autoPlay: false,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.75,
              aspectRatio: 2.0,
              initialPage: 0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                productsHomeCarouselController.homeCarouselBanners.map((e) {
              return Container(
                margin: const EdgeInsets.all(2),
                height: pageIndex ==
                        productsHomeCarouselController.homeCarouselBanners
                            .indexOf(e)
                    ? 7
                    : 5,
                width: pageIndex ==
                        productsHomeCarouselController.homeCarouselBanners
                            .indexOf(e)
                    ? 7
                    : 5,
                decoration: BoxDecoration(
                  color: pageIndex ==
                          productsHomeCarouselController.homeCarouselBanners
                              .indexOf(e)
                      ? SolhColors.Grey_1
                      : SolhColors.grey_2,
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class ProductsSearchCategories extends StatelessWidget {
  ProductsSearchCategories({super.key});
  final ProductsCategoryController productsCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return productsCategoryController.isLoading.value
          ? MyLoader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Search by',
                    style: SolhTextStyles.QS_body_semi_1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 3 / 4),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        productsCategoryController.productCategoryList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: SolhColors.Tertiary_Red.withOpacity(0.5)),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LayoutBuilder(builder: (context, constraints) {
                              return Container(
                                width: constraints.maxWidth,
                                height: 15.h,
                                decoration: const BoxDecoration(
                                  color: SolhColors.Tertiary_Red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                ),
                                child: Image.network(productsCategoryController
                                    .productCategoryList[index].categoryImage!),
                              );
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              productsCategoryController
                                  .productCategoryList[index].categoryName!,
                              style: SolhTextStyles.QS_cap_semi,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
    });
  }
}

class FeatureProductsSection extends StatelessWidget {
  FeatureProductsSection({super.key});
  final FeatureProductsController featureProductsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Featured Products",
          //onPressed: () {},
        ),
        Obx(() {
          return featureProductsController.isLoading.value
              ? MyLoader()
              : SizedBox(
                  height: 380,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemCount:
                        featureProductsController.featureProductList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ProductsCard(
                        afterDiscountPrice: featureProductsController
                            .featureProductList[index].afterDiscountPrice,
                        description: featureProductsController
                            .featureProductList[index].description,
                        price: featureProductsController
                            .featureProductList[index].price,
                        productImage: featureProductsController
                            .featureProductList[index].productImage,
                        productName: featureProductsController
                            .featureProductList[index].productName,
                        productQuantity: featureProductsController
                            .featureProductList[index].productQuantity,
                        sId: featureProductsController
                            .featureProductList[index].sId,
                        stockAvailable: featureProductsController
                            .featureProductList[index].stockAvailable,
                        isInWishlist: featureProductsController
                                .featureProductList[index].isWishlisted ??
                            false,
                        inCartItems: featureProductsController
                            .featureProductList[index].inCartCount,
                        currency: featureProductsController
                            .featureProductList[index].currency,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.productDetailScreen,
                              arguments: {
                                "id": featureProductsController
                                    .featureProductList[index].sId,
                                'key': ObjectKey(featureProductsController
                                    .featureProductList[index].sId)
                              });
                        },
                      );
                    },
                  ),
                );
        })
      ],
    );
  }
}

class YouMightFindHelpfulSection extends StatelessWidget {
  const YouMightFindHelpfulSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "You Might Find Helpful",
          onPressed: () {},
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

class NextBottomBar extends StatelessWidget {
  NextBottomBar({super.key, this.showShadow = true});

  final ProductsCartController productsCartController = Get.find();
  final bool showShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: showShadow
              ? const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8))
              : null,
          color: SolhColors.white,
          boxShadow: showShadow
              ? <BoxShadow>[
                  const BoxShadow(
                      blurRadius: 2, spreadRadius: 2, color: Colors.black26)
                ]
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              productsCartController.isCartSheetOpen.value
                  ? Navigator.of(context).pop()
                  : showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return const InCartItemsBottomSheet();
                      },
                    );
              productsCartController.isCartSheetOpen.value =
                  productsCartController.isCartSheetOpen.value
                      ? !productsCartController.isCartSheetOpen.value
                      : !productsCartController.isCartSheetOpen.value;
            },
            child: Row(
              children: [
                const Text(
                  "1 items",
                  style: SolhTextStyles.CTA,
                ),
                Obx(() {
                  return productsCartController.isCartSheetOpen.value
                      ? const Icon(
                          Icons.arrow_drop_down,
                          color: SolhColors.primary_green,
                        )
                      : const Icon(
                          Icons.arrow_drop_up,
                          color: SolhColors.primary_green,
                        );
                })
              ],
            ),
          ),
          SolhGreenMiniButton(
            child: Text(
              'Next',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          )
        ],
      ),
    );
  }
}

class InCartItemsBottomSheet extends StatelessWidget {
  const InCartItemsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    height: 8,
                    width: 40,
                    decoration: BoxDecoration(
                      color: SolhColors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.find<ProductsCartController>().isCartSheetOpen.value =
                          false;
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      CupertinoIcons.clear_thick,
                      color: SolhColors.grey,
                    ),
                  )
                ],
              ),
            ),
            const GetHelpDivider(),
            ListView.separated(
              padding: const EdgeInsets.only(right: 12),
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const GetHelpDivider(),
              itemBuilder: (context, index) {
                return const InCartProductItemCard();
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: NextBottomBar(
            showShadow: false,
          ),
        )
      ],
    );
  }
}
