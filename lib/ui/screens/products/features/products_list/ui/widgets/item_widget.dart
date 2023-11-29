import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/cart_count_btn.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.image,
      this.productName,
      this.quantity,
      this.itemPrice,
      this.currency,
      this.discountedPrice,
      required this.onAddedCart,
      this.inCartNo,
      this.isWishListed,
      required this.onIncreaseCartCount,
      required this.onDecreaseCartCount,
      this.descrition});

  final String? descrition;
  final String image;
  final String? productName;
  final String? quantity;
  final int? itemPrice;
  final String? currency;
  final int? discountedPrice;
  final int? inCartNo;
  final bool? isWishListed;
  final Function() onAddedCart;
  final Function() onIncreaseCartCount;
  final Function() onDecreaseCartCount;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 195,
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: image,
                  errorWidget: (context, url, error) {
                    return Image.asset("assets/icons/app-bar/no-image.png");
                  },
                  placeholder: (context, url) {
                    return Image.asset("assets/images/opening_link.gif");
                  },
                  fit: BoxFit.fill,
                )),
            const SizedBox(width: 20),
            Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName ?? '',
                          style: SolhTextStyles.QS_body_2_bold.copyWith(
                              color: SolhColors.black,
                              fontFamily: GoogleFonts.quicksand().fontFamily),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Html(data: descrition!.trim(), style: {
                        "p": Style(
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: FontSize(12),
                        )
                      }),
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
                                  mrp: itemPrice ?? 0, currency: currency)
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      inCartNo != null && inCartNo! > 0
                          ? CartCountBtn(
                              decreaseCartCount: onDecreaseCartCount,
                              increaseCartCount: onIncreaseCartCount,
                              itemInCart: inCartNo ?? 0,
                            )
                          : SolhGreenButton(
                              height: 30,
                              width: 100,
                              onPressed: onAddedCart,
                              child: Text(
                                'Add To Cart',
                                style: GoogleFonts.quicksand(
                                    textStyle: SolhTextStyles.CTA,
                                    color: SolhColors.white),
                              ))
                    ]))
          ],
        ));
  }
}

class PriceContainer extends StatelessWidget {
  const PriceContainer(
      {super.key, required this.discountedPrice, this.currency});
  final int discountedPrice;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: SolhColors.greenShade4),
      child: Text("$currency $discountedPrice",
          style: GoogleFonts.quicksand(
              textStyle: SolhTextStyles.QS_caption_2_bold.copyWith(
                  color: const Color(0xFF666666), fontSize: 12))),
    );
  }
}

class MrpContainer extends StatelessWidget {
  const MrpContainer({super.key, required this.mrp, this.currency});
  final int mrp;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("$currency",
          style: GoogleFonts.quicksand(
              textStyle:
                  SolhTextStyles.QS_cap_2.copyWith(color: SolhColors.Grey_1))),
      const SizedBox(width: 5),
      Text(
        mrp.toString(),
        style: GoogleFonts.quicksand(
            textStyle: SolhTextStyles.QS_caption.copyWith(color: Colors.grey),
            decoration: TextDecoration.lineThrough),
      )
    ]);
  }
}
