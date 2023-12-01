import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
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
      this.descrition,
      this.stock});

  final String? descrition;
  final String image;
  final String? productName;
  final String? quantity;
  final int? itemPrice;
  final String? currency;
  final int? discountedPrice;
  final int? inCartNo;
  final bool? isWishListed;
  final int? stock;
  final Function() onAddedCart;
  final Function() onIncreaseCartCount;
  final Function() onDecreaseCartCount;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 195,
        padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: image,
                    errorWidget: (context, url, error) {
                      return Image.asset("assets/icons/app-bar/no-image.png");
                    },
                    placeholder: (context, url) {
                      return Image.asset("assets/images/opening_link.gif");
                    },
                  ),
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
                      Html(data: descrition!.trim(), shrinkWrap: true, style: {
                        "body": Style(
                            padding: HtmlPaddings.zero, margin: Margins.zero),
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
                          const Spacer(),
                          stock! > 0
                              ? inCartNo != null && inCartNo! > 0
                                  ? CartCountBtn(
                                      decreaseCartCount: onDecreaseCartCount,
                                      increaseCartCount: onIncreaseCartCount,
                                      itemInCart: inCartNo ?? 0,
                                    )
                                  : SolhGreenButton(
                                      height: 30,
                                      width: 50,
                                      onPressed: onAddedCart,
                                      child: Text(
                                        'Add',
                                        style: GoogleFonts.quicksand(
                                            textStyle: SolhTextStyles.CTA,
                                            color: SolhColors.white),
                                      ))
                              : const Text("Out of Stock")
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (discountedPrice! > 0)
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: SolhColors.greenShade4,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/disount-svg.svg",
                                  height: 15,
                                  colorFilter: const ColorFilter.mode(
                                      SolhColors.primary_green,
                                      BlendMode.srcIn),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${(((itemPrice! - discountedPrice!) / itemPrice!) * 100).toInt()} % off",
                                  style: SolhTextStyles.Caption_2_semi.copyWith(
                                      color: SolhColors.primary_green),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
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
