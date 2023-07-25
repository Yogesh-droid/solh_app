import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class AlliedCardWithDiscount extends StatelessWidget {
  const AlliedCardWithDiscount(
      {super.key, required this.image, required this.name, this.discount});
  final String image;
  final String name;
  final int? discount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: SolhColors.grey_3,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Text(
                  name,
                  style: SolhTextStyles.QS_cap_semi,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          ),
          discount != null
              ? Positioned(
                  top: -20,
                  right: -20,
                  child: Transform.rotate(
                    angle: math.pi / 5,
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 45,
                        width: 75,
                        color: Colors.red,
                        child: Text(
                          "$discount % off",
                          style: SolhTextStyles.GreenButtonText.copyWith(
                              fontSize: 12),
                        )),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
