import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../routes/routes.dart';
import '../../../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../../../widgets_constants/constants/textstyles.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.itemsInCart, this.id});

  final int itemsInCart;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.checkoutScreen),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  CupertinoIcons.cart,
                  color: SolhColors.primary_green,
                ),
              ),
              if (itemsInCart > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: SolhColors.primary_green),
                    child: Text(itemsInCart.toString(),
                        style: SolhTextStyles.QS_caption_2_bold.copyWith(
                          color: SolhColors.white,
                        )),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
