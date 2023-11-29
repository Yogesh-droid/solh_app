import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/item_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/sheet_cart_add_remove_btn.dart';

import '../../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../../widgets_constants/constants/textstyles.dart';

class SheetCartItem extends StatelessWidget {
  const SheetCartItem(
      {super.key,
      required this.image,
      this.productName,
      this.quantity,
      this.itemPrice,
      this.currency,
      this.discountedPrice,
      this.inCartNo,
      this.isWishListed,
      required this.id,
      required this.onIncreaseCartCount,
      required this.onDecreaseCartCount,
      required this.onDeleteItem});

  final String image;
  final String? productName;
  final String? quantity;
  final int? itemPrice;
  final String? currency;
  final int? discountedPrice;
  final int? inCartNo;
  final bool? isWishListed;
  final String id;
  final Function() onIncreaseCartCount;
  final Function() onDecreaseCartCount;
  final Function() onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 120,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) {
                  return Image.asset("assets/icons/app-bar/no-image.png");
                },
                placeholder: (context, url) {
                  return Image.asset("assets/icons/app-bar/no-image.png");
                },
                fit: BoxFit.fill,
              )),
          const SizedBox(width: 20),
          Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(productName ?? '',
                              style: SolhTextStyles.QS_body_2_bold.copyWith(
                                  color: SolhColors.black,
                                  fontFamily:
                                      GoogleFonts.quicksand().fontFamily),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Spacer(),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: onDeleteItem,
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: SolhColors.primaryRed,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Spacer(),
                    Row(
                      children: [
                        discountedPrice! > 0
                            ? PriceContainer(
                                discountedPrice: discountedPrice ?? 0,
                                currency: currency)
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        discountedPrice! > 0
                            ? MrpContainer(
                                mrp: itemPrice ?? 0,
                                currency: currency,
                              )
                            : const SizedBox.shrink(),
                        const Spacer(),
                        SheetCartAddRemoveBtn(
                          decreaseCartCount: onDecreaseCartCount,
                          increaseCartCount: onIncreaseCartCount,
                          itemInCart: inCartNo ?? 0,
                          id: id,
                        )
                      ],
                    ),
                  ]))
        ],
      ),
    );
  }
}
