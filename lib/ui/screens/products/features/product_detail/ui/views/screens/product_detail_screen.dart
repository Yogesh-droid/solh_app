import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/ui/screens/products/features/product_detail/ui/views/widgets/product_star_widget.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetProductDeatilAppBar(),
      body: Stack(
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
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Customer reviews'),
        ProductStarWidget(rating: 4.0),
        Text('56 global rating'),
      ],
    );
  }
}

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

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

class GetProductStatsAndImage extends StatelessWidget {
  const GetProductStatsAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network("https://picsum.photos/200"),
          SizedBox(
            height: 10,
          ),
          Text(
            'Ashwagandha Gummies - Promotes stress reduction',
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
                    'Bottle of 60 Tablets',
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
                        '4.0',
                        style: SolhTextStyles.QS_body_2,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'Available in stock 20',
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
                  Text('₹ 499', style: SolhTextStyles.QS_big_body),
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
                        '₹ 699',
                        style: SolhTextStyles.QS_big_body.copyWith(
                            color: SolhColors.dark_grey,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
              Text(
                '40% OFF',
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
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(title: 'Product Details'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ReadMoreText(
              style: SolhTextStyles.QS_body_2,
              lessStyle:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
              moreStyle:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
              "industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
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
          child: Icon(
            CupertinoIcons.heart_fill,
            color: SolhColors.Grey_1,
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 50);
}
