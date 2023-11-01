import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class InCartProductItemCard extends StatelessWidget {
  const InCartProductItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
          height: 120,
          child: Image.network(
            "https://picsum.photos/200",
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Ashwagandha Gummies - Promotes stress reduction',
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    CupertinoIcons.delete,
                    color: SolhColors.primaryRed,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text('Bottle of 60 Tablets', style: SolhTextStyles.QS_caption),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: SolhColors.greenShade4,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '₹ 499',
                          style: SolhTextStyles.QS_caption_bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('MRP', style: SolhTextStyles.QS_cap_2),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '₹ 699',
                        style: SolhTextStyles.QS_caption.copyWith(
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  AddRemoveItemFromCart()
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class AddRemoveItemFromCart extends StatelessWidget {
  AddRemoveItemFromCart({super.key});
  final ValueNotifier<int> productNumber = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
      decoration: BoxDecoration(
        color: SolhColors.grey_3,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => productNumber.value > 1 ? productNumber.value-- : null,
            child: Icon(
              Icons.remove,
              size: 15,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          ValueListenableBuilder(
              valueListenable: productNumber,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: SolhTextStyles.CTA,
                );
              }),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () => productNumber.value++,
            child: Icon(
              Icons.add,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
