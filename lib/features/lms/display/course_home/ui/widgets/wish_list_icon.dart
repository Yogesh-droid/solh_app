import 'package:flutter/material.dart';

import '../../../../../../widgets_constants/constants/colors.dart';

class WishListIcon extends StatelessWidget {
  const WishListIcon({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: SolhColors.bg),
            child: const Icon(Icons.favorite_outline)),
      ),
    );
  }
}
