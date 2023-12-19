import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_home/ui/controllers/course_banner_controller.dart';

class CourseBanner extends StatelessWidget {
  const CourseBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseBannerController courseBannerController = Get.find();
    return Column(
      children: [
        Obx(() => CarouselSlider.builder(
            itemCount: courseBannerController.bannerList.length,
            itemBuilder: (context, index, index2) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl:
                        courseBannerController.bannerList[index].bannerImage ??
                            '')),
            options: CarouselOptions(
                autoPlay: true, enlargeFactor: 0.7, height: 200)))
      ],
    );
  }
}
