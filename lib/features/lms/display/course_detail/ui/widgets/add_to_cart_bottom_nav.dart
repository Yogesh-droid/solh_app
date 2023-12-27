import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/add_course_to_cart_controller.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../widgets_constants/buttons/custom_buttons.dart';

class AddToCartBottomNav extends StatelessWidget {
  const AddToCartBottomNav({super.key, required this.onTap, this.title});
  final Function() onTap;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final AddCourseToCartController addCourseToCartController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, spreadRadius: 3, blurRadius: 5)
      ]),
      child: SolhGreenButton(
          height: 40,
          onPressed: onTap,
          child: addCourseToCartController.isAddingToCart.value
              ? const ButtonLoadingAnimation(ballColor: Colors.white)
              : Text(title ?? "Add To Cart",
                  style: SolhTextStyles.CTA.copyWith(color: Colors.white))),
    );
  }
}
