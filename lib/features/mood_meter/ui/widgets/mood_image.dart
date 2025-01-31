import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_mood_list_controller.dart';

class MoodImage extends StatelessWidget {
  const MoodImage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetMoodListController getMoodListController = Get.find();
    return Obx(() => getMoodListController.selectedMood.value.media != null
        ? SizedBox(
            height: 200,
            child: CachedNetworkImage(
                imageUrl: getMoodListController.selectedMood.value.media!),
          )
        : imageLoadingShimmer());
  }

  Widget imageLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: 200,
        // width: 150,
        child: Image.asset("assets/images/logo/solh-logo.png"),
      ),
    );
  }
}
