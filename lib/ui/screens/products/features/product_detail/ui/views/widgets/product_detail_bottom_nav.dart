import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductDetailBottomNav extends StatelessWidget {
  const ProductDetailBottomNav({super.key, required this.onNextPressed});
  final Function() onNextPressed;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                blurStyle: BlurStyle.normal)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          SizedBox(
            child: Row(children: [
              Text(
                "${cartController.cartEntity.value.cartList!.items!.length} items",
                style: GoogleFonts.quicksand(
                    textStyle:
                        SolhTextStyles.CTA.copyWith(color: Colors.black)),
              ),
            ]),
          ),
          const Spacer(),
          SolhGreenButton(
              onPressed: onNextPressed,
              height: 30,
              width: 100,
              child: Text(
                "Next",
                style: GoogleFonts.quicksand(
                    textStyle:
                        SolhTextStyles.CTA.copyWith(color: SolhColors.white)),
              ))
        ]),
      ),
    );
  }
}
