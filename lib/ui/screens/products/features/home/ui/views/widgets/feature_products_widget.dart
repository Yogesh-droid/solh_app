import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class FeatureProductsWidget extends StatelessWidget {
  const FeatureProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Products",
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.productsHome);
          },
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

class ProductsCard extends StatelessWidget {
  const ProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: SolhColors.primary_green,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  )),
              Positioned(
                right: 10,
                top: 10,
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: SolhColors.grey_2,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Text(
                    "Ashwagandha || 500mg - 60 caps XXL Nutrition  0mg - 60 caps XXL Nutrition - 60 caps XXL Nutrition ",
                    style: SolhTextStyles.QS_caption_bold,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    "Hand Foot and Body Massager, Stress Ball For Adults, Trigger - 60 caps XXL Nutrition  - 60 caps XXL Nutrition ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: SolhTextStyles.QS_cap_2_semi,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("MRP", style: SolhTextStyles.QS_cap_2),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '₹ 699',
                          style: SolhTextStyles.QS_caption.copyWith(
                              decoration: TextDecoration.lineThrough),
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                          color: SolhColors.primary_green,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        '₹ 499',
                        style: SolhTextStyles.QS_caption_bold.copyWith(
                            color: SolhColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AddRemoveProductButtoon()
        ],
      ),
    );
  }
}

class AddRemoveProductButtoon extends StatelessWidget {
  AddRemoveProductButtoon({super.key});
  final ValueNotifier<int> poductNumber = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: poductNumber,
        builder: (context, value, child) {
          return value == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SolhGreenMiniButton(
                      onPressed: () => poductNumber.value++,
                      child: Text(
                        'Add To Cart',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => poductNumber.value > 0
                            ? poductNumber.value--
                            : null,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: SolhColors.primary_green,
                          child: Center(
                            child: Icon(Icons.remove, color: SolhColors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: SolhColors.primary_green)),
                        child: Center(
                            child: Text(
                          "$value",
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primary_green),
                        )),
                      ),
                      GestureDetector(
                        onTap: () => poductNumber.value++,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: SolhColors.primary_green,
                          child: Center(
                            child: Icon(Icons.add, color: SolhColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
