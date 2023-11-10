import 'package:flutter/cupertino.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/feature_products_widget.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.currency,
    required this.price,
    required this.priceAfterDiscount,
    required this.productImage,
    required this.productName,
    required this.productQuantity,
    required this.sId,
  });

  final String productImage;
  final String productName;
  final String productQuantity;
  final String currency;
  final String price;
  final String priceAfterDiscount;
  final String sId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
          height: 120,
          child: Image.network(
            productImage,
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
                      productName,
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
              Text(productQuantity, style: SolhTextStyles.QS_caption),
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
                          '$currency $priceAfterDiscount',
                          style: SolhTextStyles.QS_caption_bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // Text(, style: SolhTextStyles.QS_cap_2),

                      Text(
                        '$currency $price',
                        style: SolhTextStyles.QS_caption.copyWith(
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  Expanded(child: AddRemoveProductButtoon(productId: sId)),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
