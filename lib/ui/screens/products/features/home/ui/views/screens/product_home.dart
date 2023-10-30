import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductsHome extends StatelessWidget {
  const ProductsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(),
        body: ListView(
          children: [
            ProductsSearchBar(),
            GetHelpDivider(),
            ProductsCategories(),
            GetHelpDivider(),
            ProductsBannerCarousel(),
            GetHelpDivider(),
            ProductsSearchCategories(),
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
