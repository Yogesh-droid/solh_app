import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../../widgets_constants/constants/colors.dart';

class CartCountBtn extends StatelessWidget {
  const CartCountBtn(
      {super.key,
      required this.increaseCartCount,
      required this.decreaseCartCount,
      required this.itemInCart});
  final Function() increaseCartCount;
  final Function() decreaseCartCount;
  final int itemInCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(children: [
        InkWell(
          onTap: decreaseCartCount,
          child: Container(
              height: 30,
              color: SolhColors.primary_green,
              child: Icon(Icons.remove, color: SolhColors.white)),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green)),
          width: 50,
          child: Center(
              child: Text(itemInCart.toString(),
                  style: GoogleFonts.quicksand(
                      textStyle: SolhTextStyles.QS_body_semi_1.copyWith(
                          color: SolhColors.primary_green)))),
        ),
        InkWell(
          onTap: increaseCartCount,
          child: Container(
            height: 30,
            color: SolhColors.primary_green,
            child: Icon(Icons.add, color: SolhColors.white),
          ),
        )
      ]),
    );
  }
}
