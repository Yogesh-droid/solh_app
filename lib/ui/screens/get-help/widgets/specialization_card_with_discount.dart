import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';

import '../../../../widgets_constants/constants/textstyles.dart';

class SpecializationCardWithDiscount extends StatelessWidget {
  const SpecializationCardWithDiscount(
      {super.key, required this.image, required this.name, this.discount});
  final String image;
  final String name;
  final int? discount;

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 1.h,
        width: 10.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xFFEFEFEF)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: CircleAvatar(
                      radius: 8.w,
                      child: CircleAvatar(
                        radius: 7.8.w,
                        backgroundColor: Colors.white,
                        backgroundImage: CachedNetworkImageProvider(image),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 25.w,
                    child: Text(
                      name,
                      style: SolhTextStyles.QS_cap_semi,
                    ),
                  ),
                ],
              ),
            ),
            discount != null && discount! > 0
                ? Positioned(
                    top: -20,
                    right: -20,
                    child: Transform.rotate(
                        angle: math.pi / 5,
                        child: Obx(() => Container(
                            alignment: Alignment.bottomCenter,
                            height: 45,
                            width: 75,
                            color: profileController.orgColor1.value.isNotEmpty
                                ? Color(int.parse(
                                    "0xFF${profileController.orgColor1}"))
                                : Colors.red,
                            child: Text(
                              "$discount % off",
                              style: SolhTextStyles.GreenButtonText.copyWith(
                                  fontSize: 12),
                            )))),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
