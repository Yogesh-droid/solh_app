import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/in_cart_product_item_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductsHome extends StatelessWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(),
        body: Stack(
          children: [
            ListView(
              children: [
                ProductsSearchBar(),
                GetHelpDivider(),
                ProductsCategories(),
                GetHelpDivider(),
                ProductsBannerCarousel(),
                GetHelpDivider(),
                ProductsSearchCategories(),
                GetHelpDivider(),
                FeatureProductsSection(),
                GetHelpDivider(),
                YouMightFindHelpfulSection(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: NextBottomBar())
          ],
        ));
  }
}

PreferredSizeWidget getAppbar() {
  return SolhAppBar(
    title: Text(""),
    isLandingScreen: false,
    isProductsPage: true,
  );
}

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: SearchBar(
        hintText: "Search for Mental wellness Products",
        hintStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(color: SolhColors.Grey_1)),
        trailing: [
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
  const ProductsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Categories",
            style: SolhTextStyles.QS_body_semi_1,
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: 6,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 15,
                );
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SolhColors.Tertiary_Red,
                      ),
                      child: Icon(
                        Icons.medical_information,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Supplements",
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductsBannerCarousel extends StatefulWidget {
  ProductsBannerCarousel({super.key});

  @override
  State<ProductsBannerCarousel> createState() => _ProductsBannerCarouselState();
}

class _ProductsBannerCarouselState extends State<ProductsBannerCarousel> {
  final CarouselController buttonCarouselController = CarouselController();

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
            items: imageArray
                .map(
                  (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(e)),
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageArray.map((e) {
              print(" $pageIndex  ${imageArray.indexOf(e)}");
              return Container(
                margin: EdgeInsets.all(2),
                height: pageIndex == imageArray.indexOf(e) ? 7 : 5,
                width: pageIndex == imageArray.indexOf(e) ? 7 : 5,
                decoration: BoxDecoration(
                  color: pageIndex == imageArray.indexOf(e)
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
  const ProductsSearchCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Search by',
            style: SolhTextStyles.QS_body_semi_1,
          ),
          SizedBox(
            height: 24,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 3 / 4),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 9,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: SolhColors.Tertiary_Red.withOpacity(0.5)),
                  borderRadius: BorderRadius.only(
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
                        decoration: BoxDecoration(
                          color: SolhColors.Tertiary_Red,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                        ),
                        child: Icon(CupertinoIcons.add),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Mood Stablizers',
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
  }
}

class FeatureProductsSection extends StatelessWidget {
  const FeatureProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Featured Products",
          onPressed: () {},
        ),
        SizedBox(
          height: 380,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              return ProductsCard();
            },
          ),
        )
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              return ProductsCard();
            },
          ),
        )
      ],
    );
  }
}

class NextBottomBar extends StatelessWidget {
  const NextBottomBar({super.key, this.showShadow = true});
  final bool showShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: showShadow
              ? BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8))
              : null,
          color: SolhColors.white,
          boxShadow: showShadow
              ? <BoxShadow>[
                  BoxShadow(
                      blurRadius: 2, spreadRadius: 2, color: Colors.black26)
                ]
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (context) {
                  return InCartItemsBottomSheet();
                },
              );
            },
            child: Row(
              children: [
                Text(
                  "1 items",
                  style: SolhTextStyles.CTA,
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: SolhColors.primary_green,
                )
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
                  Icon(
                    CupertinoIcons.clear_thick,
                    color: SolhColors.grey,
                  )
                ],
              ),
            ),
            GetHelpDivider(),
            ListView.separated(
              padding: EdgeInsets.only(right: 12),
              itemCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => GetHelpDivider(),
              itemBuilder: (context, index) {
                return InCartProductItemCard();
              },
            ),
            SizedBox(
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
